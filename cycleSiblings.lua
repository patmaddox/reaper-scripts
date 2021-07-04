function cycleSiblings(first, last, iterator)
  selectedTrack = reaper.GetSelectedTrack(0, 0)

  if not selectedTrack then
    return
  end

  selectedParent = reaper.GetParentTrack(selectedTrack)
  siblings = {}

  for trackIndex = first, last, iterator do
    track = reaper.GetTrack(0, trackIndex)

    if reaper.GetParentTrack(track) == selectedParent then
      siblings[#siblings + 1] = track
    end
  end

  for i, track in ipairs(siblings) do
    if track == selectedTrack then
      nextTrack = siblings[i + 1] or siblings[1]

      if nextTrack then
        reaper.SetTrackSelected(selectedTrack, false)
        reaper.SetTrackSelected(nextTrack, true)
      end

      break
    end
  end
end

numTracks = reaper.CountTracks(0)

function selectNextSibling()
  cycleSiblings(0, numTracks - 1, 1)
end

function selectPrevSibling()
  cycleSiblings(numTracks - 1, 0, - 1)
end
