import ConfigUtils from '../../utils.js'
const hyprland = await Service.import('hyprland')

// Credits go to Aylur. https://github.com/Aylur/ags/tree/main/example/notification-popups
const notifications = await Service.import('notifications')
notifications.popupTimeout = 5000

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
function NotificationIcon({ app_entry, app_icon, image }) {
    if (image) {
        return Widget.Box({
            css:
                `background-image: url("${image}");` +
                'background-size: contain;' +
                'background-repeat: no-repeat;' +
                'background-position: center;',
        })
    }

    let icon = 'dialog-information-symbolic'
    if (Utils.lookUpIcon(app_icon)) icon = app_icon

    if (app_entry && Utils.lookUpIcon(app_entry)) icon = app_entry

    return Widget.Box({
        child: Widget.Icon(icon),
    })
}

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
function Notification(n) {
    const icon = Widget.Box({
        vpack: 'center',
        class_name: 'icon',
        child: NotificationIcon(n),
    })

    const title = Widget.Label({
        class_name: 'title',
        xalign: 0,
        justification: 'left',
        hexpand: true,
        max_width_chars: 24,
        truncate: 'end',
        wrap: true,
        label: n.summary,
        use_markup: true,
    })

    const body = Widget.Label({
        class_name: 'body',
        hexpand: true,
        use_markup: true,
        xalign: 0,
        justification: 'left',
        label: n.body,
        wrap: true,
    })

    const actions = Widget.Box({
        class_name: 'actions',
        children: n.actions.map(({ id, label }) =>
            Widget.Button({
                class_name: 'action-button',
                on_clicked: () => {
                    n.invoke(id)
                    n.dismiss()
                },
                hexpand: true,
                child: Widget.Label(label),
            })
        ),
    })

    return Widget.EventBox(
        {
            attribute: { id: n.id },
            on_primary_click: n.dismiss,
        },
        Widget.Box(
            {
                class_name: `notification ${n.urgency}`,
                vertical: true,
            },
            Widget.Box([icon, Widget.Box({ vertical: true }, title, body)]),
            actions
        )
    )
}

function NotificationPopups() {
    const list = Widget.Box({
        vertical: true,
        children: notifications.popups.map(Notification),
    })

    function onNotified(_, /** @type {number} */ id) {
        const n = notifications.getNotification(id)
        if (n) list.children = [Notification(n), ...list.children]
    }

    function onDismissed(_, /** @type {number} */ id) {
        list.children.find((n) => n.attribute.id === id)?.destroy()
    }

    list.hook(notifications, onNotified, 'notified').hook(
        notifications,
        onDismissed,
        'dismissed'
    )
    let gdkMonitorId = hyprland.active.bind('monitor').as((e) => {
        const found = hyprland.monitors.find(
            (mon) => mon.id === ConfigUtils.getGdkMonitorId(e.name)
        )
        if (found === undefined) {
            return 0
        }
        return found.id
    })

    return Widget.Window({
        monitor: gdkMonitorId,
        name: gdkMonitorId.as((e) => `notifications${e}`),
        class_name: 'notification-popups',
        anchor: ['top', 'right'],
        layer: 'overlay',
        exclusivity: 'normal',
        child: Widget.Box({
            css: 'min-width: 2px; min-height: 2px;',
            class_name: 'notifications',
            vertical: true,
            child: list,
        }),
    })
}

export { NotificationPopups }
