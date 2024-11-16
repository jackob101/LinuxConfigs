import variables from "../../variables.js"

function CloseButton(on_click) {
    return Widget.Button({
        class_name: "close_button",
        hpack: "end",
        on_clicked: on_click,
        child: Widget.Icon({
            icon: "window-close-symbolic"
        })
    })
}

export default CloseButton
