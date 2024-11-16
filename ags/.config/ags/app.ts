import { App, Gtk, Gtk } from "astal/gtk3";
import { bind, Binding, exec } from "astal";
import style from "./style.scss";
import Bar from "./widget/bar/init";
import Hyprland from "gi://AstalHyprland";

exec("sass ./style.scss /tmp/style.css");

function main() {
    const hypr = Hyprland.get_default();
    let bars = new Map();

    for (const entry of hypr.get_monitors()) {
        bars.set(entry, Bar(entry));
    }

    hypr.connect("monitor-added", (_, monitor) => {
        print("Added new monitor");
        bars.set(monitor, Bar(monitor));
    });

    hypr.connect("monitor-removed", (_, monitor) => {
        print("monitor-removed");
        bars.delete(monitor);
    });
}

App.start({
    instanceName: "bar",
    css: "/tmp/style.css",
    main: main,
    requestHandler(request, res) {},
});
