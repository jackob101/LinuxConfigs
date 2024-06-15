import GLib from "gi://GLib"

function Launcher() {
    return Widget.Button({
        on_primary_click: () => Utils.execAsync("anyrun"),
        child: Widget.Icon({
            class_name: "launcher",
            icon: GLib.get_os_info("LOGO"),
            size: 28,
            tooltip_text: "Launcher",
        })
    })
}

export { Launcher }
