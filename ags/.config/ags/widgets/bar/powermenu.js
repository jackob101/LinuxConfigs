function Powermenu() {
    return Widget.Button({
        cursor: "pointer",
        class_name: "powerbutton smaller-icon",
        on_clicked: () => Utils.execAsync("/home/jackob/.config/rofi/powermenu/script.sh"),
        child: Widget.Icon("application-exit-symbolic"),
    })
}

export { Powermenu }
