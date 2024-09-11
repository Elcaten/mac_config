local This = {}

function This.toggleApp(bundleId, createNewWindowHandler, successHandler)
    return function()
        local app = hs.application.get(bundleId)

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
            hs.alert.show("Launch", 0.5)
            hs.application.launchOrFocusByBundleID(bundleId)
            app = hs.application.get(bundleId)
        end

        successHandler(app)
    end
end

return This