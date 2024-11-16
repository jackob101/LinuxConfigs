import variables from "../../variables.js"

function ExitScreen() {
    return Widget.Button({
        cursor: "pointer",
        class_name: "powerbutton smaller-icon",
        on_clicked: () => App.openWindow(variables.exit_screen_name),
        child: Widget.Icon("application-exit-symbolic"),
    })
}

export { ExitScreen }
