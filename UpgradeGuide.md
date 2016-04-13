# What's New #

> What's different in Ultimate Mapchooser v3 compared to the earlier version is that the plugin is now modular. Separate key features of the plugin have been moved into their own _modules_--separate plugins--which communicate with a _core_ plugin.

> There were several reasons for this, but mainly it makes bugs much easier to fix, the plugin much easier to extend, shortens development time, and is much more efficient.

# Upgrade Guide #

> Estimated Duration: 5-10 mins

> First, all files that aren't your UMC-Mapcycle file (_umc\_mapcycle.txt_ by default) and your Vote Warnings definition file (_vote\_warnings.txt_ by default) will no longer be useable. You should at least hold on to your _ultimate\_mapchooser.cfg_ file since it will be a useful reference when configuring v3.  All other files, including the translations and _ultimate-mapchooser.smx_ should be removed from the server and can be deleted.

> Once you've cleared all necessary files, you can install the most recent version of Ultimate Mapchooser. Make sure you don't accidentally overwrite _umc\_mapcycle.txt_ and _vote\_warnings.txt_ when installing.

> Ultimate Mapchooser v3 is a little different when it comes to configuration. By default, all main features of the plugin are enabled. You can turn off individual modules by deleting the corresponding _.smx_ files (or moving them to the _addons/sourcemod/plugins/disabled_ folder). If you're not certain of what a module does, you can read its [documentation](http://code.google.com/p/sourcemod-ultimate-mapchooser/w/list).

> Now that you're satisfied with what modules you have enabled, you can configure each module using the .cfg files located in _cfg/sourcemod_. Each modules _.cfg_ will have the same name as the _.smx_. You will notice that v3 either has a lot more, or a lot less to cvars to set. If you're using every module, there will be a lot more to configure, but if you're using only a small amount of modules, then it's much less than previous version. The reason for the overall increase in cvars is because v3 allows much more customizability for various features, whereas in earlier version they would have to share the same cvar.

> Once you're done configuring all of the modules, restart your server, and now you can then use Ultimate Mapchooser just like you always have!

# Quick Guide #
  1. Remove all files from previous version except for _umc\_mapcycle.txt_ and _vote\_warnings.txt_.
  1. Install v3, make sure you don't accidentally overwrite any old files you want to save (the two in step 1).
  1. Disable any plugins (called modules) you will not be using.
  1. For all modules you keep enabled, configure them using the corresponding _.cfg_ files located in _cfg/sourcemod_.
  1. Restart your server.
  1. Party on, dudes.