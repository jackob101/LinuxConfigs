import { Gdk } from "astal/gtk3";
import Wireplumber from "gi://AstalWp";
import { bind, execAsync, Variable } from "astal";
import Astal from "gi://Astal";
/**
 * @param {number} bottom
 * @param {number} top
 * @param {number} value
 */
function limitWithRange(bottom: number, top: number, value: number) {
    if (value >= top) {
        return top;
    } else if (value <= bottom) {
        return bottom;
    } else {
        return value;
    }
}

function Volume() {
    const wp = Wireplumber.get_default();
    if (wp == null) {
        return null;
    }
    const icons = [
        { threshold: 101, icon: "overamplified" },
        { threshold: 67, icon: "high" },
        { threshold: 34, icon: "medium" },
        { threshold: 1, icon: "low" },
        { threshold: 0, icon: "muted" },
    ];

    function clickHandler(_: any, event: Astal.ClickEvent) {
        switch (event.button) {
            case Astal.MouseButton.PRIMARY:
                wp?.defaultSpeaker.set_mute(!wp?.defaultSpeaker.get_mute());
                break;
            case Astal.MouseButton.SECONDARY:
                execAsync("pavucontrol");
                break;
        }
    }

    function scrollHandler(_: any, event: Astal.ScrollEvent) {
        // This is some of the most retarted shit I have ever seen. Why the fuck does
        // ScrollDirection enum have value SMOOTH and is it the only value thats returned?
        // This is why direction is checked by delta
        if (event.delta_y < 0) {
            wp?.defaultSpeaker.set_volume(
                limitWithRange(0, 150, wp?.defaultSpeaker.get_volume() + 0.05),
            );
        } else {
            wp?.defaultSpeaker.set_volume(
                limitWithRange(0, 150, wp?.defaultSpeaker.get_volume() - 0.05),
            );
        }
    }

    const volumeBind = bind(wp?.audio.defaultSpeaker, "volume");
    const muteBind = bind(wp?.audio.defaultSpeaker, "mute");

    const iconBind = Variable.derive(
        [volumeBind, muteBind],
        (volume, isMute) => {
            const icon = isMute
                ? { threshold: 0, icon: "muted" }
                : icons.find((entry) => {
                      if (entry.threshold <= volume * 100) {
                          return entry;
                      }
                  });
            if (icon === null || icon === undefined) {
                return "";
            }
            return `audio-volume-${icon.icon}-symbolic`;
        },
    );

    const volumeDisplayBind = volumeBind.as((e) => {
        return Math.trunc(e * 100).toString() + "%";
    });

    const icon = (
        <box>
            <icon
                className="icon-18"
                tooltipText={volumeDisplayBind}
                icon={bind(iconBind)}
            />
        </box>
    );

    return (
        <eventbox
            className="volume"
            cursor="pointer"
            onScroll={scrollHandler}
            onClick={clickHandler}
        >
            {icon}
        </eventbox>
    );
}

export { Volume };
