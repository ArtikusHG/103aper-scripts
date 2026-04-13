local ctx = reaper.ImGui_CreateContext('PipewireBufferSizeMenu')
local items = {'64', '128', '256', '512', '1024', '2048'}

function Loop()
local window_flags = reaper.ImGui_WindowFlags_AlwaysAutoResize()
  local visible, open = reaper.ImGui_Begin(ctx, 'Buffer size', true, window_flags)

  if visible then
    for i, name in ipairs(items) do
      if reaper.ImGui_Button(ctx, name, 103, 25) then
        os.execute('pw-metadata -n settings 0 clock.force-quantum ' .. name)
        open = false
      end
    end

    reaper.ImGui_End(ctx)
  end

  if open then reaper.defer(Loop) end
end

reaper.defer(Loop)
