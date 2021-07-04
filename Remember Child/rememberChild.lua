extName = "paat.remember-child"
selectedTrack = reaper.GetSelectedTrack(0, 0)

if not selectedTrack then
  return
end

selectedId = reaper.GetTrackGUID(selectedTrack)

function rememberChild()
  parentId = "master"
  selectedParent = reaper.GetParentTrack(selectedTrack)

  if selectedParent then
    parentId = reaper.GetTrackGUID(selectedParent)
  end

  reaper.SetProjExtState(0, extName, parentId, selectedId)
end

function restoreChild()
  retVal, childId = reaper.GetProjExtState(0, extName, selectedId)

  if childId ~= "" then
    for trackIndex = 0, reaper.CountTracks(0) - 1 do
      track = reaper.GetTrack(0, trackIndex)

      if childId == reaper.GetTrackGUID(track) then
        reaper.SetTrackSelected(selectedTrack, false)
        reaper.SetTrackSelected(track, true)
        break
      end
    end
  end
end
