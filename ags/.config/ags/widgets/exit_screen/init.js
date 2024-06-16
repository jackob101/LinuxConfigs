import variables from "../../variables.js"
import Header from "./header.js"
import CloseButton from "./close_button.js"
import ShortcutsLegend from "./shortcut_legend.js"
import Uptime from "./uptime.js"
import PowerButtons from "./power_buttons.js"
import { hyprland } from "resource:///com/github/Aylur/ags/service/hyprland.js"

const operations = {
    shutdown: {
        shortcut_key: "p",
        name: "Shutdown",
        command: () => Utils.execAsync("shutdown now")
    },
    logout: {
        shortcut_key: "l",
        name: "Logout",
        command: () => Utils.execAsync("hyprctl dispatch exit")
    },
    reboot: {
        shortcut_key: "r",
        name: "Reboot",
        command: () => Utils.execAsync("reboot")
    },
    sleep: {
        shortcut_key: "s",
        name: "Sleep",
        //TODO: fill this later
        command: () => Utils.execAsync("")
    },
    lock: {
        shortcut_key: "o",
        name: "Lock",
        //TODO: fill this later
        command: () => Utils.execAsync("")
    },
    escape: {
        shortcut_key: "Escape",
        name: "Escape",
        command: () => App.closeWindow(variables.exit_screen_name)
    }
}

function ExitScreen() {

    return Widget.Window({
        visible: false,
        name: variables.exit_screen_name,
        class_name: "exit-screen",
        anchor: ["top", "bottom", "right", "left"],
        exclusivity: "normal",
        keymode: "exclusive",
        layer: "top",
        margins: [100],
        child: Widget.Box({
            class_name: "content",
            children: [
                Widget.Box({
                    class_name: "left_part",
                }),
                Widget.CenterBox({
                    hexpand: true,
                    hpack: "fill",
                    center_widget: Widget.CenterBox({
                        vertical: true,
                        center_widget: Widget.Box({
                            vertical: true,
                            spacing: 40,
                            children: [
                                Header(),
                                PowerButtons(operations),
                                Uptime()
                            ]
                        })
                    })
                }),
                Widget.Box({
                    vertical: true,
                    class_name: "right_part",
                    children: [
                        CloseButton(operations.escape.command),
                        Widget.Box({
                            vexpand: true,
                        }),
                        ShortcutsLegend(operations)
                    ]
                })
            ]
        }),
        setup: w => {
            Object.keys(operations)
                .forEach((key, _index) => {
                    let operationDetails = operations[key]
                    w.keybind([],
                        operationDetails.shortcut_key,
                        (_self, _event) => operationDetails.command())
                })
        }
    })
}

export { ExitScreen }
