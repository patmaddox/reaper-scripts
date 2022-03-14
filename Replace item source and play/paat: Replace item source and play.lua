mx = reaper.OpenMediaExplorer("", false)
reaper.Main_OnCommand(1016, 0) -- Transport: Stop
reaper.JS_Window_OnCommand(mx, 42002) -- Media: Replace source in selected media items
reaper.Main_OnCommand(1007, 0) -- Transport: Play
