function Wallpaper() {
    return Widget.Button({
        on_primary_click: () => Utils.execAsync("waypaper-engine run --wayland"),
        child: Widget.Icon({
            class_name: "wallpaper smaller-icon",
            icon: "computer-symbolic",
            // size: 28,
            tooltip_text: "Wallpaper settings",
        })
    })
}

export { Wallpaper }
