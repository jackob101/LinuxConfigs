import { Bar } from "./widgets/bar/init.js"
const hyprland = await Service.import("hyprland")

const scss = `${App.configDir}/style.scss`

// target css file
const css = `./style.css`

// make sure sassc is installed on your system
Utils.exec(`sassc ${scss} ${css}`)

App.config({
    style: "./style.css",
    windows: hyprland.monitors.map(e => Bar(e.name, e.id)),
})

export { }
