import Network from "gi://AstalNetwork";
import { bind } from "astal";
function NetworkWidget() {
    let network = Network.get_default();
    const iconBinding = bind(network, "connectivity").as((e) => {
        switch (e) {
            case Network.Connectivity.FULL:
                return "network-connected-symbolic";
            case Network.Connectivity.LIMITED:
            case Network.Connectivity.PORTAL:
            case Network.Connectivity.UNKNOWN:
            case Network.Connectivity.NONE:
                return "network-disconnected-symbolic";
        }
    });

    return (
        <button>
            <icon className="icon network" icon={iconBinding} />
        </button>
    );
}

export { NetworkWidget as Network };
