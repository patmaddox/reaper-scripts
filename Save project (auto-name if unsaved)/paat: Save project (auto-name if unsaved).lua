function error_exit(message)
  reaper.ShowMessageBox(message, "Error", 0)
  os.exit()
end

function save_with_auto_name()
  retval, savepath = reaper.get_config_var_string("defsavepath")
  if savepath == "" then
    error_exit("Cannot save file - no default save path")
  end

  filename = os.date("%Y-%m-%d-%H_%M_%S")
  new_dir = savepath .. "/" .. filename
  new_path = new_dir .. "/" .. filename .. ".RPP"

  if reaper.file_exists(new_path) then
    error_exit("File already exists: \n" .. new_path)
  end

  if reaper.RecursiveCreateDirectory(new_dir, 0) == 0 then
    error_exit("Unable to create dir: \n" .. new_dir)
  end

  reaper.Main_SaveProjectEx(proj, new_path, 0)
  reaper.Main_openProject("noprompt:" .. new_path)
end

proj, projfn = reaper.EnumProjects(-1)
if projfn == "" then
  save_with_auto_name()
else
  reaper.Main_SaveProject(proj)
end
