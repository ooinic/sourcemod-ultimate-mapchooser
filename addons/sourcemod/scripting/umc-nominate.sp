/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *                               Ultimate Mapchooser - Nominations                               *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
 
#pragma semicolon 1

#include <sourcemod>
#include <umc-core>
#include <umc_utils>

#undef REQUIRE_PLUGIN

//Auto update
#include <updater>
#if AUTOUPDATE_DEV
    #define UPDATE_URL "http://www.ccs.neu.edu/home/steell/sourcemod/ultimate-mapchooser/dev/updateinfo-umc-nominate.txt"
#else
    #define UPDATE_URL "http://www.ccs.neu.edu/home/steell/sourcemod/ultimate-mapchooser/updateinfo-umc-nominate.txt"
#endif

#define NOMINATE_ADMINFLAG_KEY "nominate_flags"

//Plugin Information
public Plugin:myinfo =
{
    name        = "[UMC] Nominations",
    author      = "Steell",
    description = "Extends Ultimate Mapchooser to allow players to nominate maps.",
    version     = PL_VERSION,
    url         = "http://forums.alliedmods.net/showthread.php?t=134190"
};

//Changelog:
/*
3.3.2 (3/4/2012)
Updated UMC Logging functionality
Added ability to view the current mapcycle of all modules
*/

        ////----CONVARS-----/////
new Handle:cvar_filename        = INVALID_HANDLE;
new Handle:cvar_nominate        = INVALID_HANDLE;
new Handle:cvar_nominate_tiered = INVALID_HANDLE;
new Handle:cvar_mem_map         = INVALID_HANDLE;
new Handle:cvar_mem_group       = INVALID_HANDLE;
new Handle:cvar_sort            = INVALID_HANDLE;
//new Handle:cvar_nominate_limit  = INVALID_HANDLE;
new Handle:cvar_flags           = INVALID_HANDLE;
        ////----/CONVARS-----/////

//Mapcycle
new Handle:map_kv = INVALID_HANDLE;
new Handle:umc_mapcycle = INVALID_HANDLE;

//Memory queues. Used to store the previously played maps.
new Handle:vote_mem_arr    = INVALID_HANDLE;
new Handle:vote_catmem_arr = INVALID_HANDLE;

new Handle:nom_menu_groups[MAXPLAYERS+1]    = { INVALID_HANDLE, ... };
new Handle:nom_menu_nomgroups[MAXPLAYERS+1] = { INVALID_HANDLE, ... };
//EACH INDEX OF THE ABOVE TWO ARRAYS CORRESPONDS TO A NOMINATION MENU FOR A PARTICULAR CLIENT.

//Has a vote neem completed?
new bool:vote_completed;

//Can we nominate?
new bool:can_nominate;

//TODO: Add cvar for enable/disable exclusion from prev. maps.
//      Possible bug: nomination menu doesn't want to display twice for a client in a map.
//      Alphabetize based off of display, not actual map name.
//
//      New map option called "nomination_group" that sets the "real" map group to be used when
//      the map is nominated for a vote. Useful for tiered nomination menu.

//************************************************************************************************//
//                                        SOURCEMOD EVENTS                                        //
//************************************************************************************************//

//Called when the plugin is finished loading.
public OnPluginStart()
{
    /*cvar_nominate_limit = CreateConVar(
        "sm_umc_nominate_limit",
        "0",
        "Determines how many maps can be nominated during a map.\n 0 = Unlimited.",
        0, true, 0.0, true, 1.0
    );*/
    
    cvar_flags = CreateConVar(
        "sm_umc_nominate_defaultflags",
        "",
        "Flags necessary for a player to nominate a map, if flags are not specified by a map in the mapcycle. If empty, all players can nominate."
    );

    cvar_sort = CreateConVar(
        "sm_umc_nominate_sorted",
        "0",
        "Determines the order of maps in the nomination menu.\n 0 - Same as mapcycle,\n 1 - Alphabetical",
        0, true, 0.0, true, 1.0
    );

    cvar_nominate_tiered = CreateConVar(
        "sm_umc_nominate_tiermenu",
        "0",
        "Organizes the nomination menu so that users select a group first, then a map.",
        0, true, 0.0, true, 1.0
    );
    
    cvar_nominate = CreateConVar(
        "sm_umc_nominate_enabled",
        "1",
        "Specifies whether players have the ability to nominate maps for votes.",
        0, true, 0.0, true, 1.0
    );
    
    cvar_filename = CreateConVar(
        "sm_umc_nominate_cyclefile",
        "umc_mapcycle.txt",
        "File to use for Ultimate Mapchooser's map rotation."
    );
    
    cvar_mem_group = CreateConVar(
        "sm_umc_nominate_groupexclude",
        "0",
        "Specifies how many past map groups to exclude from nominations.",
        0, true, 0.0
    );
    
    cvar_mem_map = CreateConVar(
        "sm_umc_nominate_mapexclude",
        "4",
        "Specifies how many past maps to exclude from nominations. 1 = Current Map Only",
        0, true, 0.0
    );
    
    //Create the config if it doesn't exist, and then execute it.
    AutoExecConfig(true, "umc-nominate");
    
    //Reg the nominate console cmd
    RegConsoleCmd("sm_nominate", Command_Nominate);
    
    //Make listeners for player chat. Needed to recognize chat commands ("rtv", etc.)
    AddCommandListener(OnPlayerChat, "say");
    AddCommandListener(OnPlayerChat, "say2"); //Insurgency Only
    AddCommandListener(OnPlayerChat, "say_team");
    
    //Initialize our memory arrays
    new numCells = ByteCountToCells(MAP_LENGTH);
    vote_mem_arr    = CreateArray(numCells);
    vote_catmem_arr = CreateArray(numCells);
    
    //Load the translations file
    LoadTranslations("ultimate-mapchooser.phrases");
    
#if AUTOUPDATE_ENABLE
    if (LibraryExists("updater"))
    {
        Updater_AddPlugin(UPDATE_URL);
    }
#endif
}


#if AUTOUPDATE_ENABLE
//Called when a new API library is loaded. Used to register UMC auto-updating.
public OnLibraryAdded(const String:name[])
{
    if (StrEqual(name, "updater"))
    {
        Updater_AddPlugin(UPDATE_URL);
    }
}
#endif


//************************************************************************************************//
//                                           GAME EVENTS                                          //
//************************************************************************************************//

//Called after all config files were executed.
public OnConfigsExecuted()
{
    can_nominate = ReloadMapcycle();
    vote_completed = false;
    
    new Handle:groupArray = INVALID_HANDLE;
    for (new i = 0; i < sizeof(nom_menu_groups); i++)
    {
        groupArray = nom_menu_groups[i];
        if (groupArray != INVALID_HANDLE)
        {
            CloseHandle(groupArray);
            nom_menu_groups[i] = INVALID_HANDLE;
        }
    }
    for (new i = 0; i < sizeof(nom_menu_nomgroups); i++)
    {
        groupArray = nom_menu_groups[i];
        if (groupArray != INVALID_HANDLE)
        {
            CloseHandle(groupArray);
            nom_menu_groups[i] = INVALID_HANDLE;
        }
    }
    
    //Grab the name of the current map.
    decl String:mapName[MAP_LENGTH];
    GetCurrentMap(mapName, sizeof(mapName));
    
    decl String:groupName[MAP_LENGTH];
    UMC_GetCurrentMapGroup(groupName, sizeof(groupName));
    
    if (can_nominate && StrEqual(groupName, INVALID_GROUP, false))
    {
        KvFindGroupOfMap(umc_mapcycle, mapName, groupName, sizeof(groupName));
    }
    
    //Add the map to all the memory queues.
    new mapmem = GetConVarInt(cvar_mem_map);
    new catmem = GetConVarInt(cvar_mem_group);
    AddToMemoryArray(mapName, vote_mem_arr, mapmem);
    AddToMemoryArray(groupName, vote_catmem_arr, (mapmem > catmem) ? mapmem : catmem);
    
    if (can_nominate)
        RemovePreviousMapsFromCycle();
}


//Called when a player types in chat.
//Required to handle user commands.
public Action:OnPlayerChat(client, const String:command[], argc)
{
    //Return immediately if...
    //    ...nothing was typed.
    if (argc == 0) return Plugin_Continue;
    
    DEBUG_MESSAGE("Checking for chat command...")
    
    if (!GetConVarBool(cvar_nominate))
    {
        return Plugin_Continue;
    }
    
    //Get what was typed.
    decl String:text[80];
    GetCmdArg(1, text, sizeof(text));
    TrimString(text);
    
    decl String:arg[MAP_LENGTH];
    
    new next = BreakString(text, arg, sizeof(arg));
    
    if (StrEqual(arg, "nominate", false))
    {
        DEBUG_MESSAGE("Chat command registered!")
    
        if (vote_completed || !can_nominate)
        {
            PrintToChat(client, "\x03[UMC]\x01 %t", "No Nominate Nextmap");
        }
        else //Otherwise, let them nominate.
        {
            DEBUG_MESSAGE("Checking for argument...")
            if (next != -1)
            {
                DEBUG_MESSAGE("Argument found!")
                BreakString(text[next], arg, sizeof(arg));
                
                //Get the selected map.
                decl String:groupName[MAP_LENGTH], String:nomGroup[MAP_LENGTH];
                KvFindGroupOfMap(map_kv, arg, groupName, sizeof(groupName));
                
                if (StrEqual(groupName, INVALID_GROUP))
                {
                    //TODO: Change to translation phrase
                    PrintToChat(client, "\x03[UMC]\x01 Could not find map \"%s\"", arg);
                }
                else
                {
                    KvRewind(map_kv);
                    
                    KvJumpToKey(map_kv, groupName);
                    
                    decl String:adminFlags[64];
                    GetConVarString(cvar_flags, adminFlags, sizeof(adminFlags));
                    
                    KvGetString(map_kv, NOMINATE_ADMINFLAG_KEY, adminFlags, sizeof(adminFlags), adminFlags);
    
                    KvJumpToKey(map_kv, arg);
                    
                    KvGetString(map_kv, NOMINATE_ADMINFLAG_KEY, adminFlags, sizeof(adminFlags), adminFlags);
                    
                    KvGetString(map_kv, "nominate_group", nomGroup, sizeof(nomGroup), groupName);
                    
                    KvGoBack(map_kv);
                    KvGoBack(map_kv);

                    new clientFlags = GetUserFlagBits(client);
                    
                    //Check if admin flag set
                    if (adminFlags[0] != '\0' && !(clientFlags & ReadFlagString(adminFlags)))
                    {
                        //TODO: Change to translation phrase
                        PrintToChat(client, "\x03[UMC]\x01 Could not find map \"%s\"", arg);
                    }
                    else
                    {
                        //Nominate it.
                        UMC_NominateMap(map_kv, arg, groupName, client, nomGroup);
                        
                        DEBUG_MESSAGE("Nomination via extra arg -- chat.")
                    
                        //Display a message.
                        decl String:clientName[MAX_NAME_LENGTH];
                        GetClientName(client, clientName, sizeof(clientName));
                        PrintToChatAll("\x03[UMC]\x01 %t", "Player Nomination", clientName, arg);
                        LogUMCMessage("%s has nominated '%s' from group '%s'", clientName, arg, groupName);
                    }
                }
                
            }
            else
            {
                DEBUG_MESSAGE("No argument! Displaying menu.")
                if (!DisplayNominationMenu(client))
                    PrintToChat(client, "\x03[UMC]\x01 %t", "No Nominate Nextmap");
            }                
        }
    }
    return Plugin_Continue;
}


//************************************************************************************************//
//                                              SETUP                                             //
//************************************************************************************************//

//Parses the mapcycle file and returns a KV handle representing the mapcycle.
Handle:GetMapcycle()
{
    //Grab the file name from the cvar.
    decl String:filename[PLATFORM_MAX_PATH];
    GetConVarString(cvar_filename, filename, sizeof(filename));
    
    //Get the kv handle from the file.
    new Handle:result = GetKvFromFile(filename, "umc_rotation");
    
    //Log an error and return empty handle if...
    //    ...the mapcycle file failed to parse.
    if (result == INVALID_HANDLE)
    {
        LogError("SETUP: Mapcycle failed to load!");
        return INVALID_HANDLE;
    }
    
    //Success!
    return result;
}


//Reloads the mapcycle. Returns true on success, false on failure.
bool:ReloadMapcycle()
{
    if (umc_mapcycle != INVALID_HANDLE)
    {
        CloseHandle(umc_mapcycle);
        umc_mapcycle = INVALID_HANDLE;
    }
    if (map_kv != INVALID_HANDLE)
    {
        CloseHandle(map_kv);
        map_kv = INVALID_HANDLE;
    }
    umc_mapcycle = GetMapcycle();
    
    return umc_mapcycle != INVALID_HANDLE;
}


//
RemovePreviousMapsFromCycle()
{
    map_kv = CreateKeyValues("umc_rotation");
    KvCopySubkeys(umc_mapcycle, map_kv);
    FilterMapcycleFromArrays(map_kv, vote_mem_arr, vote_catmem_arr, GetConVarInt(cvar_mem_group));
}


//************************************************************************************************//
//                                            COMMANDS                                            //
//************************************************************************************************//

//sm_nominate
public Action:Command_Nominate(client, args)
{
    if (!GetConVarBool(cvar_nominate))
        return Plugin_Handled;
        
    if (vote_completed || !can_nominate)
    {
        ReplyToCommand(client, "\x03[UMC]\x01 %t", "No Nominate Nextmap");
    }
    else //Otherwise, let them nominate.
    {
        if (args > 0)
        {
            //Get what was typed.
            decl String:arg[MAP_LENGTH];
            GetCmdArg(1, arg, sizeof(arg));
            TrimString(arg);
            
            //Get the selected map.
            decl String:groupName[MAP_LENGTH], String:nomGroup[MAP_LENGTH];
            KvFindGroupOfMap(map_kv, arg, groupName, sizeof(groupName));
            
            if (StrEqual(groupName, INVALID_GROUP))
            {
                //TODO: Change to translation phrase
                ReplyToCommand(client, "\x03[UMC]\x01 Could not find map \"%s\"", arg);
            }
            else
            {
                KvRewind(map_kv);
                
                KvJumpToKey(map_kv, groupName);
                
                decl String:adminFlags[64];
                GetConVarString(cvar_flags, adminFlags, sizeof(adminFlags));
                
                KvGetString(map_kv, NOMINATE_ADMINFLAG_KEY, adminFlags, sizeof(adminFlags), adminFlags);

                KvJumpToKey(map_kv, arg);
                
                KvGetString(map_kv, NOMINATE_ADMINFLAG_KEY, adminFlags, sizeof(adminFlags), adminFlags);
                
                KvGetString(map_kv, "nominate_group", nomGroup, sizeof(nomGroup), groupName);
                
                KvGoBack(map_kv);
                KvGoBack(map_kv);

                new clientFlags = GetUserFlagBits(client);
                
                //Check if admin flag set
                if (adminFlags[0] != '\0' && !(clientFlags & ReadFlagString(adminFlags)))
                {
                    //TODO: Change to translation phrase
                    ReplyToCommand(client, "\x03[UMC]\x01 Could not find map \"%s\"", arg);
                }
                else
                {
                    //Nominate it.
                    UMC_NominateMap(map_kv, arg, groupName, client, nomGroup);
                    
                    DEBUG_MESSAGE("Nomination via extra arg -- command.")
                
                    //Display a message.
                    decl String:clientName[MAX_NAME_LENGTH];
                    GetClientName(client, clientName, sizeof(clientName));
                    PrintToChatAll("\x03[UMC]\x01 %t", "Player Nomination", clientName, arg);
                    LogUMCMessage("%s has nominated '%s' from group '%s'", clientName, arg, groupName);
                }
            }
            
        }
        else
        {
            if (!DisplayNominationMenu(client))
                ReplyToCommand(client, "\x03[UMC]\x01 %t", "No Nominate Nextmap");
        }                
    }
    return Plugin_Handled;
}


//************************************************************************************************//
//                                           NOMINATIONS                                          //
//************************************************************************************************//

//Displays a nomination menu to the given client.
bool:DisplayNominationMenu(client)
{
    if (!can_nominate)
        return false;

    LogUMCMessage("%N wants to nominate a map.", client);

    //Build the menu
    new Handle:menu = GetConVarBool(cvar_nominate_tiered) 
                        ? BuildTieredNominationMenu(client)
                        : BuildNominationMenu(client);
    
    //Display the menu if...
    //    ...the menu was built successfully.
    if (menu != INVALID_HANDLE)
    {
#if UMC_DEBUG
        new bool:result = DisplayMenu(menu, client, 0);
        DEBUG_MESSAGE("Displaying nomination menu to client. (%i)", result)
        return result;
#else
        return DisplayMenu(menu, client, 0);
#endif
    }
    return false;
}


//Creates and returns the Nomination menu for the given client.
Handle:BuildNominationMenu(client, const String:cat[]=INVALID_GROUP)
{
    //Initialize the menu
    new Handle:menu = CreateMenu(Handle_NominationMenu, MenuAction_Display);
    
    //Set the title.
    SetMenuTitle(menu, "%T", "Nomination Menu Title", LANG_SERVER);
    
    if (!StrEqual(cat, INVALID_GROUP))
    {
        //Make it so we can return to the previous menu.
        SetMenuExitBackButton(menu, true);
    }
    
    KvRewind(map_kv);

    //Get map array.
    new Handle:mapArray = UMC_CreateValidMapArray(map_kv, umc_mapcycle, cat, true, false);
                                                  
    if (GetConVarBool(cvar_sort))
        SortMapTrieArray(mapArray);
    
    new size = GetArraySize(mapArray);
    if (size == 0)
    {
        LogError("No maps available to be nominated.");
        CloseHandle(menu);
        CloseHandle(mapArray);
        return INVALID_HANDLE;
    }
    
    //Variables
    new numCells = ByteCountToCells(MAP_LENGTH);
    nom_menu_groups[client] = CreateArray(numCells);
    nom_menu_nomgroups[client] = CreateArray(numCells);
    new Handle:menuItems = CreateArray(numCells);
    new Handle:menuItemDisplay = CreateArray(numCells);
    decl String:display[MAP_LENGTH], String:gDisp[MAP_LENGTH];
    new Handle:mapTrie = INVALID_HANDLE;
    decl String:mapBuff[MAP_LENGTH], String:groupBuff[MAP_LENGTH];
    decl String:group[MAP_LENGTH];
    
    decl String:dAdminFlags[64], String:gAdminFlags[64], String:mAdminFlags[64];
    GetConVarString(cvar_flags, dAdminFlags, sizeof(dAdminFlags));
    new clientFlags = GetUserFlagBits(client);
    
    for (new i = 0; i < size; i++)
    {
        mapTrie = GetArrayCell(mapArray, i);
        GetTrieString(mapTrie, MAP_TRIE_MAP_KEY, mapBuff, sizeof(mapBuff));
        GetTrieString(mapTrie, MAP_TRIE_GROUP_KEY, groupBuff, sizeof(groupBuff));
        
        KvJumpToKey(map_kv, groupBuff);
        
        KvGetString(map_kv, "nominate_group", group, sizeof(group), INVALID_GROUP);
        
        if (StrEqual(group, INVALID_GROUP))
            strcopy(group, sizeof(group), groupBuff);
        
        if (UMC_IsMapNominated(mapBuff, group))
        {
            KvGoBack(map_kv);
            continue;
        }
        
        KvGetString(map_kv, "display-template", gDisp, sizeof(gDisp), "{MAP}");
        KvGetString(map_kv, NOMINATE_ADMINFLAG_KEY, gAdminFlags, sizeof(gAdminFlags), dAdminFlags);
        
        KvJumpToKey(map_kv, mapBuff);
        
        KvGetString(map_kv, NOMINATE_ADMINFLAG_KEY, mAdminFlags, sizeof(mAdminFlags), gAdminFlags);
        
        //Check if admin flag set
        if (mAdminFlags[0] != '\0')
        {
            //Check if player has admin flag
            if (!(clientFlags & ReadFlagString(mAdminFlags)))
                continue;
        }
        
        //Get the name of the current map.
        KvGetSectionName(map_kv, mapBuff, sizeof(mapBuff));
        
        KvGetString(map_kv, "display", display, sizeof(display), gDisp);
                    
        if (strlen(display) == 0)
            display = mapBuff;
        else
            ReplaceString(display, sizeof(display), "{MAP}", mapBuff, false);
                
        //Add map data to the arrays.
        PushArrayString(menuItems, mapBuff);
        PushArrayString(menuItemDisplay, display);
        PushArrayString(nom_menu_groups[client], groupBuff);
        PushArrayString(nom_menu_nomgroups[client], group);
        
        KvRewind(map_kv);
    }
    
    //Add all maps from the nominations array to the menu.
    AddArrayToMenu(menu, menuItems, menuItemDisplay);
    
    //No longer need the arrays.
    CloseHandle(menuItems);
    CloseHandle(menuItemDisplay);
    ClearHandleArray(mapArray);
    CloseHandle(mapArray);
    
    //Success!
    return menu;
}


//Creates the first part of a tiered Nomination menu.
Handle:BuildTieredNominationMenu(client)
{
    //Initialize the menu
    new Handle:menu = CreateMenu(Handle_TieredNominationMenu, MenuAction_Display);

    KvRewind(map_kv);
    
    //Get group array.
    new Handle:groupArray = UMC_CreateValidMapGroupArray(map_kv, umc_mapcycle, true, false);

    new size = GetArraySize(groupArray);
    
    //Log an error and return nothing if...
    //    ...the number of maps available to be nominated
    if (size == 0)
    {
        LogError("No maps available to be nominated.");
        CloseHandle(menu);
        CloseHandle(groupArray);
        return INVALID_HANDLE;
    }
    
    //Variables
    decl String:dAdminFlags[64], String:gAdminFlags[64], String:mAdminFlags[64];
    GetConVarString(cvar_flags, dAdminFlags, sizeof(dAdminFlags));
    new clientFlags = GetUserFlagBits(client);
    
    new Handle:menuItems = CreateArray(ByteCountToCells(MAP_LENGTH));
    decl String:groupName[MAP_LENGTH], String:mapName[MAP_LENGTH];
    new bool:excluded = true;
    for (new i = 0; i < size; i++)
    {
        GetArrayString(groupArray, i, groupName, sizeof(groupName));
        
        KvJumpToKey(map_kv, groupName);
        
        KvGetString(map_kv, NOMINATE_ADMINFLAG_KEY, gAdminFlags, sizeof(gAdminFlags), dAdminFlags);        
        
        KvGotoFirstSubKey(map_kv);
        do
        {
            KvGetSectionName(map_kv, mapName, sizeof(mapName));
            
            if (UMC_IsMapNominated(mapName, groupName))
                continue;
            
            KvGetString(map_kv, NOMINATE_ADMINFLAG_KEY, mAdminFlags, sizeof(mAdminFlags), gAdminFlags);
        
            //Check if admin flag set
            if (mAdminFlags[0] != '\0')
            {
                //Check if player has admin flag
                if (!(clientFlags & ReadFlagString(mAdminFlags)))
                    continue;
            }
            
            excluded = false;
            break;
        }
        while (KvGotoNextKey(map_kv));
        
        if (!excluded)
            PushArrayString(menuItems, groupName);
            
        KvGoBack(map_kv);
        KvGoBack(map_kv);
    }
    
    //Add all maps from the nominations array to the menu.
    AddArrayToMenu(menu, menuItems);
    
    //No longer need the arrays.
    CloseHandle(menuItems);
    CloseHandle(groupArray);

    //Success!
    return menu;
}


//Called when the client has picked an item in the nomination menu.
public Handle_NominationMenu(Handle:menu, MenuAction:action, client, param2)
{
    switch (action)
    {
        case MenuAction_Select: //The client has picked something.
        {
            //Get the selected map.
            decl String:map[MAP_LENGTH], String:group[MAP_LENGTH], String:nomGroup[MAP_LENGTH];
            GetMenuItem(menu, param2, map, sizeof(map));
            GetArrayString(nom_menu_groups[client], param2, group, sizeof(group));
            GetArrayString(nom_menu_nomgroups[client], param2, nomGroup, sizeof(nomGroup));
            
            KvRewind(map_kv);
            
            //Nominate it.
            UMC_NominateMap(map_kv, map, group, client, nomGroup);
            
            //Display a message.
            decl String:clientName[MAX_NAME_LENGTH];
            GetClientName(client, clientName, sizeof(clientName));
            DEBUG_MESSAGE("Nomination via menu.")
            PrintToChatAll("\x03[UMC]\x01 %t", "Player Nomination", clientName, map);
            LogUMCMessage("%s has nominated '%s' from group '%s'", clientName, map, group);
            
            //Close handles for stored data for the client's menu.
            CloseHandle(nom_menu_groups[client]);
            CloseHandle(nom_menu_nomgroups[client]);
            nom_menu_groups[client] = INVALID_HANDLE;
            nom_menu_nomgroups[client] = INVALID_HANDLE;
        }
        case MenuAction_End: //The client has closed the menu.
        {
            //We're done here.
            CloseHandle(menu);
        }
        case MenuAction_Display: //the menu is being displayed
        {
            new Handle:panel = Handle:param2;
            
            decl String:buffer[255];
            Format(buffer, sizeof(buffer), "%T", "Nomination Menu Title", client);
            
            SetPanelTitle(panel, buffer);
        }
        case MenuAction_Cancel:
        {
            if (param2 == MenuCancel_ExitBack)
            {
                //Build the menu
                new Handle:newmenu = BuildTieredNominationMenu(client);
                
                //Display the menu if...
                //    ..the menu was built successfully.
                if (newmenu != INVALID_HANDLE)
                    DisplayMenu(newmenu, client, 20);
            }
        }
    }
}


//Handles the first-stage tiered nomination menu.
public Handle_TieredNominationMenu(Handle:menu, MenuAction:action, client, param2)
{
    if (action == MenuAction_Select)
    {
        decl String:cat[MAP_LENGTH];
        GetMenuItem(menu, param2, cat, sizeof(cat));
    
        //Build the menu
        new Handle:newmenu = BuildNominationMenu(client, cat);
    
        //Display the menu if...
        //    ..the menu was built successfully.
        if (newmenu != INVALID_HANDLE)
        {  
            DisplayMenu(newmenu, client, 20);
        }
    }
    else
        Handle_NominationMenu(menu, action, client, param2);
}


//************************************************************************************************//
//                                   ULTIMATE MAPCHOOSER EVENTS                                   //
//************************************************************************************************//

//Called when UMC requests that the mapcycle should be reloaded.
public UMC_RequestReloadMapcycle()
{
    can_nominate = ReloadMapcycle();
    if (can_nominate)
        RemovePreviousMapsFromCycle();
}


//Called when UMC has set a next map.
public UMC_OnNextmapSet(Handle:kv, const String:map[], const String:group[], const String:display[])
{
    vote_completed = true;
}

//Called when UMC has extended a map.
public UMC_OnMapExtended()
{
    vote_completed = false;
}


//Called when UMC requests that the mapcycle is printed to the console.
public UMC_DisplayMapCycle(client, bool:filtered)
{
    PrintToConsole(client, "Module: Nominations");
    if (filtered)
    {
        PrintToConsole(client, "Maps available to nominate:");
        new Handle:filteredMapcycle = UMC_FilterMapcycle(
            map_kv, umc_mapcycle, true, false
        );
        PrintKvToConsole(filteredMapcycle, client);
        CloseHandle(filteredMapcycle);
        PrintToConsole(client, "Maps available for map change (if nominated):");
        filteredMapcycle = UMC_FilterMapcycle(
            map_kv, umc_mapcycle, true, true
        );
        PrintKvToConsole(filteredMapcycle, client);
        CloseHandle(filteredMapcycle);
    }
    else
    {
        PrintKvToConsole(umc_mapcycle, client);
    }
}

