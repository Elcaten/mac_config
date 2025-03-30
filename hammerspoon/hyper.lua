local This = {}

This.hyperMode = hs.hotkey.modal.new({}, 'F18')

-- Enter Hyper Mode when F18 (Hyper) is pressed
local function enterHyperMode()
   This.hyperMode:enter()
end

-- Leave Hyper Mode when F18 (Hyper) is pressed
local function exitHyperMode()
   This.hyperMode:exit()
end

-- Utility to bind handler to Hyper+key
function This.bind(modifiers, key, handler)
   This.hyperMode:bind(modifiers or {}, key, handler, nil, handler)
end

-- Binds the enter/exit functions of the Hyper modal to all combinations of modifiers
function This.install(hotKey)
   hs.hotkey.bind({}, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "shift" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "ctrl" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "ctrl", "shift" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "cmd" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "cmd", "shift" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "cmd", "ctrl" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "cmd", "ctrl", "shift" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "alt" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "alt", "shift" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "alt", "ctrl" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "alt", "ctrl", "shift" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "alt", "cmd" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "alt", "cmd", "shift" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "alt", "cmd", "ctrl" }, hotKey, enterHyperMode, exitHyperMode)
   hs.hotkey.bind({ "alt", "cmd", "shift", "ctrl" }, hotKey, enterHyperMode, exitHyperMode)
end

return This
