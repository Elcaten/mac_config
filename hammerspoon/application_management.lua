local This = {}

function This.toggleApp(name, createNewWindowHandler, successHandler)
    return function()
        local app = hs.application.get(name)

        if app then
            if not app:mainWindow() then
                hs.alert.show("New Window", 0.5)
                createNewWindowHandler(app)
            elseif app:isFrontmost() then
                hs.alert.show("Hide", 0.5)
                app:hide()
            else
                hs.alert.show("Activate", 0.5)
                app:activate()
            end
        else
            hs.application.launchOrFocus(name)
            app = hs.application.get(name)
        end

        successHandler(app)
    end
end

return This