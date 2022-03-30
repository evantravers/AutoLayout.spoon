# AutoLayout

AutoLayout is a simple spoon that lets you configure a list of of hs.layout spaces and apply them automatically whenever your monitor configuration changes.

If you want to automatically detect the monitor at runtime instead of init, use a lambda in your table.

Example:
```lua
local autoLayout = spoon.Autolayout

hs.fnutils.map(Config.applications, function(app_config)
  local bundleID = app_config['bundleID']
  if app_config.layouts then
    hs.fnutils.map(app_config.layouts, function(rule)
      local title_pattern, screen, layout = rule[1], rule[2], rule[3]
      table.insert(layouts,
        {
          hs.application.get(bundleID),                  -- application name
          title_pattern,                                 -- window title
          function() autolayout.whichScreen(screen) end, -- screen
          layout,                                        -- layout
          nil,
          nil
        }
      )
    end)
  end
end)

autolayout
:setDefault(layouts)
:start()
```
