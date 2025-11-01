-- F2 to toggle Alacritty fast
hs.hotkey.bind({}, "F2", function()
    local app = hs.application.find("Alacritty")

    if not app then
        hs.application.launchOrFocus("Alacritty")
        return
    end

    if app:isFrontmost() then
        app:hide()
    else
        app:activate()
        app:unhide()
    end
end)

