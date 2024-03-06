{ config, lib, ... }:

with lib;
let
  cfg = config.lab.wireguard;
  labcfg = config.lab;
in {

  options.lab.wireguard = {
    enable = mkEnableOption "Enables support for wireguard";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    networking.wireguard = {
      enable = true;

      interfaces."name" = {
        table = "main";
        # socketNamespace = "container";
        # privateKeyFile = "/path/to/file";
        # privateKey = "secret";
        # preSetup = "${pkgs.iproute2}/bin/ip netns add foo";
        # postShutdown = "${pkgs.openresolv}/bin/resolvconf -d wg0";
        # postSetup = ''printf "nameserver 10.200.100.1" | ${pkgs.openresolv}/bin/resolvconf -a wg0 -m 0'';

        # mtu = 1280;
        # metric = 700;
        # listenPort = 51820;
        # ips = [ "192.168.2.1/24" ];
        # interfaceNamespace = "init";
        # generatePrivateKeyFile = true;
        # fwMark = "0x6e6978";
        # allowedIPsAsRoutes = false;

        peers = [
          {
            # publicKey = "xTIBA5rboUvnH4htodjb6e697QjLERt1NAB4mZqp8Dg=";
            # presharedKeyFile = "/private/wireguard_psk";
            # presharedKey = "rVXs/Ni9tu3oDBLS4hOyAUAa1qTWVA3loR8eL20os3I=";
            # persistentKeepalive = 25;
            # name = "bernd";
            # endpoint = "demo.wireguard.io:12913";
            # dynamicEndpointRefreshSeconds = 5;
            # dynamicEndpointRefreshRestartSeconds = 5;
            # allowedIPs = [ "10.192.122.3/32" ];
          }
        ];
      };
    };
  };
}
