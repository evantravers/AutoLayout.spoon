--- === AUTOLAYOUT ===
---
--- This is largely stolen from @megalithic's epic work. This lets application's
--- windows automatically re-settle depending on whether I'm on a single laptop
--- or a dock with an external (and now primary) monitor.
---
--- I prefer applications full screened (for the most part, so this is
--- simplified. I also don't roll with more than two monitors, but this should
--- scale theoretically.
---
--- When you start it, it starts the watcher. You can also trigger an autolayout
--- manually by calling module.autoLayout()
---
---

local m = {}

m.num_of_screens = 0
m.whichScreen = function(num)
  local displays = hs.screen.allScreens()
  if displays[num] ~= nil then
    return displays[num]
  else
    return hs.screen.primaryScreen()
  end
end

-- autoLayout() :: self
-- Evaluates module.config and obeys the layouts.
-- Includes any layouts in module.config.layout as overrides.
function m:autoLayout()
  print(hs.inspect(m.layouts))
  hs.layout.apply(m.layouts, string.match)

  return self
end

function m:setLayouts(layouts)
  m.layouts = layouts

  return self
end

-- initialize watchers
function m:start()
  m.watcher = hs.screen.watcher.new(function()
    if m.num_of_screens ~= #hs.screen.allScreens() then
      m.autoLayout()
      m.num_of_screens = #hs.screen.allScreens()
    end
  end):start()
end

function m:stop()
  m.watcher:stop()
  m.watcher = nil
end

return m
