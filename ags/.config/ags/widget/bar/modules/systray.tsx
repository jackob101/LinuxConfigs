import { bind, Variable } from "astal";
import Astal from "gi://Astal";
import Tray from "gi://AstalTray";

let showTray = Variable(false);

function SysTray() {
    const tray = Tray.get_default();

    function trayItemClickEventHandler(
        item: Tray.TrayItem,
        event: Astal.ClickEvent,
    ) {
        if (event.button == Astal.MouseButton.PRIMARY) {
            item.activate(event.x, event.y);
        } else if (event.button == Astal.MouseButton.SECONDARY) {
            item.create_menu();
        }
    }

    function toggleButtonClickHandler(_: any, event: Astal.ClickEvent) {
        switch (event.button) {
            case Astal.MouseButton.PRIMARY:
                showTray.set(!showTray.get());
        }
    }

    function mapTrayItems(entries: Tray.TrayItem[]) {
        let result = [];
        for (const entry of entries) {
            if (entry.get_gicon() === null) {
                continue;
            }
            result.push(
                <button
                    className="item"
                    onClick={(_, event) =>
                        trayItemClickEventHandler(entry, event)
                    }
                >
                    <icon className={"icon"} gIcon={entry.get_gicon()} />
                </button>,
            );
        }
        return result;
    }

    const trayItems = Variable.derive(
        [bind(tray, "items"), showTray],
        (trayItems, shouldShowTray) => {
            if (shouldShowTray) {
                return mapTrayItems(trayItems);
            } else {
                return [];
            }
        },
    );
    const toggleButton = (
        <button
            cursor="pointer"
            className="toggle"
            onClick={toggleButtonClickHandler}
        >
            <icon
                className="icon"
                icon={showTray((e) =>
                    e ? "pan-end-symbolic" : "pan-start-symbolic",
                )}
            />
        </button>
    );

    return (
        <box className="systray">
            <box spacing={5}>{bind(trayItems)}</box>
            {toggleButton}
        </box>
    );
}

export { SysTray };
