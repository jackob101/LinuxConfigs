import { hyprland } from "resource:///com/github/Aylur/ags/service/hyprland.js"
import variables from "../../variables.js"

/**
 * @param {{ [x: string]: {shortcut_key: string, name: string, command: function}; }} operations
 */
function PowerButtons(operations) {


    function CreateButton(tooltip, iconName, command) {
        return Widget.Button({
            on_clicked: command,
            class_name: "power_button",
            tooltip_text: tooltip,
            child: Widget.CenterBox({
                vertical: true,
                spacing: 20,
                center_widget:
                    Widget.Icon({
                        class_name: "power_button_icon",
                        icon: iconName
                    })
            })
        })
    }

    //TODO: The name of this variable is horrible but it will work for now
    let shouldBeVerticalCache = null
    return Widget.Box({
        spacing: 20,
        //TODO: There is still one bug with this, when panel is opened, we switch screen, and close panel with keybind, the next panel we open will have orientation of the previous screen :/
        vertical: hyprland.active
            .bind("monitor")
            .as(monitorId => {
                if (App.getWindow(variables.exit_screen_name)?.is_active) {
                    return shouldBeVerticalCache;
                } else {
                    let monitor = hyprland.getMonitor(monitorId.id)
                    let shouldBeVertical = monitor != undefined ? monitor.x > 910 : false
                    shouldBeVerticalCache = shouldBeVertical;
                    return shouldBeVertical
                }
            }),
        children: [
            CreateButton("Shutdown", "system-shutdown-symbolic", operations["shutdown"]),
            CreateButton("Logout", "system-log-out-symbolic", operations["logout"]),
            CreateButton("Reboot", "system-reboot-symbolic", operations["reboot"]),
            CreateButton("Suspend", "system-suspend-symbolic", operations["sleep"]),
            CreateButton("Lock", "system-lock-screen-symbolic", operations["lock"]),
        ]
    })
}

export default PowerButtons
