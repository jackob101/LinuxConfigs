import { Gdk } from "astal/gtk3";
import { exec } from "astal";
import Hyprland from "gi://AstalHyprland";
import { WorkspaceRule, WorkspaceRulesMap } from "./types/workspaces";
const display = Gdk.Display.get_default();

function getGdkMonitorId(connectorName: string): Gdk.Monitor | null {
    if (display == null) return null;
    const screen = display.get_default_screen();
    for (let i = 0; i < display.get_n_monitors(); ++i) {
        let name = screen.get_monitor_plug_name(i);
        if (connectorName === name) {
            return display.get_monitor(i);
        }
    }
    return null;
}

function getWorkspaceRules(): WorkspaceRulesMap {
    try {
        const rules = exec("hyprctl workspacerules -j");

        const workspaceRulesMap: WorkspaceRulesMap = {};

        JSON.parse(rules).forEach((entry: WorkspaceRule) => {
            const workspaceNum = parseInt(entry.workspaceString, 10);
            if (isNaN(workspaceNum)) {
                return;
            }
            if (Object.hasOwnProperty.call(workspaceRulesMap, entry.monitor)) {
                workspaceRulesMap[entry.monitor].push(workspaceNum);
            } else {
                workspaceRulesMap[entry.monitor] = [workspaceNum];
            }
        });

        return workspaceRulesMap;
    } catch (err) {
        console.error(err);
        return {};
    }
}

export default { getGdkMonitorId, getWorkspaceRules };
