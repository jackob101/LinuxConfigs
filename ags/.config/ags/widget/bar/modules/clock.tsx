import { bind, Variable } from "astal";

export default function Clock() {
    const date = Variable("tes").poll(1000, [
        "bash",
        "-c",
        'date "+%H:%M  -  %a %d"',
    ]);

    const fullDate = Variable("tes").poll(1000, [
        "bash",
        "-c",
        'date "+%T %A %B %y"',
    ]);

    return (
        <box tooltipText={bind(fullDate)}>
            <label label={bind(date)} />
        </box>
    );
}
