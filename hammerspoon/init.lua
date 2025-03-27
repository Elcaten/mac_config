require "keyboard_layout"
local wm = require "window_management"
local hyper = require('hyper')
local am = require('application_management')

hyper.install('F19')

local function sendKeyCode(key, modifiers)
    modifiers = modifiers or {}

    return function()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
    end
end

local function bindWithAllModifiers(fromKey, toKey)
    hyper.bind({}, fromKey, sendKeyCode(toKey))
    hyper.bind({ "shift" }, fromKey, sendKeyCode(toKey, { "shift" }))
    hyper.bind({ "option" }, fromKey, sendKeyCode(toKey, { "option" }))
    hyper.bind({ "shift", "option" }, fromKey, sendKeyCode(toKey, { "shift", "option" }))
end

-- Map Hyper + h to delete
hyper.bind({}, 'h', sendKeyCode('delete'))

-- Map Hyper + ijkl to move cursor
bindWithAllModifiers('j', 'left')
bindWithAllModifiers('l', 'right')
bindWithAllModifiers('i', 'up')
bindWithAllModifiers('k', 'down')

-- Map Hyper + <KEY> to CMD+ALT+CTRL+<KEY>
-- So that other apps can use HyperKey binding
local keyNames = { "v", "p", "w" }
for _, keyName in ipairs(keyNames) do
    hyper.bind({}, keyName, sendKeyCode(keyName, { "cmd", "alt", "ctrl" }))
end

-- Map Hyper + <KEY> to toggle apps
hyper.bind({}, 'b', am.toggleApp("net.shinyfrog.bear", function(app)
    app:selectMenuItem({ "Window", "Main Window" })
end))
hyper.bind({}, 't', am.toggleApp("com.culturedcode.ThingsMac", function(app)
    app:selectMenuItem({ "File", "New Things Window" })
end))
hyper.bind({}, 'c', am.toggleApp("com.apple.iCal", function(app)
    app:selectMenuItem({ "Window", "Calendar" })
end))
hyper.bind({}, '`', am.toggleApp("com.mitchellh.ghostty", function(app)
    app:selectMenuItem({ "File", "New Window" })
end, function(app)
    hs.application.get("com.mitchellh.ghostty"):mainWindow():moveToUnit '[100,50,0,0]'
end))
hyper.bind({}, 'm', am.toggleApp("com.apple.mail", function(app)
    app:selectMenuItem({ "File", "New Viewer Window" })
    hs.application.get("com.mitchellh.ghostty"):mainWindow():moveToUnit '[100,50,0,0]'
end))

-- Window Management
hyper.bind({}, 'return', function()
    wm.windowMaximize(0)
end)
hyper.bind({}, '[', function()
    wm.moveWindowToPosition(wm.screenPositions.left)
end)
hyper.bind({}, ']', function()
    wm.moveWindowToPosition(wm.screenPositions.right)
end)
hyper.bind({ "option" }, '[', function()
    hs.window.focusedWindow():moveOneScreenWest()
end)
hyper.bind({ "option" }, ']', function()
    hs.window.focusedWindow():moveOneScreenEast()
end)
