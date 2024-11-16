import Gtk from "gi://Gtk?version=3.0"
import { Bar } from "./widgets/bar/init.js"
import { ExitScreen } from "./widgets/exit_screen/init.js"
import { NotificationPopups } from "./widgets/notification_poup/init.js"

const hyprland = await Service.import("hyprland")

const test = "Test global string"

const scss = `${App.configDir}/style.scss`

// target css file
const css = `./style.css`

// make sure sassc is installed on your system
Utils.exec(`sassc ${scss} ${css}`)

/**
* @type Gtk.Window[]
*/
let windows = hyprland.monitors.map(e => Bar(e.name, e.id));
windows.push(ExitScreen())
windows.push(NotificationPopups())

App.config({
    style: "./style.css",
    windows: windows,
})

export { }
