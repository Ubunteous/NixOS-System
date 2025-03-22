{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.lab.wireguard;
  labcfg = config.lab;
in {
  options.lab.wireguard = {
    enable = mkEnableOption "Enables support for wireguard";
  };

  config = mkIf (labcfg.enable && cfg.enable) {

    networking = {
      firewall.allowedUDPPorts = [ 51820 ];

      nat.enable = true;
      nat.externalInterface = "wlp1s0";
      nat.internalInterfaces = [ "wg0" ];
    };

    networking.wireguard = {
      enable = true;

      # "wg0" is an arbitrary name for the interface
      interfaces."wg0" = {
        # generate with: wg genkey | tee ~/Documents/privatekey | wg pubkey > ~/Documents/publickey

        # server: server private key. client: client private key
        privateKey = ''
          AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
        '';
        # ips = [ "10.100.0.1/24" ]; for server # "10.100.0.2/24" for client
        ips = [ "10.100.0.1/24" ];
        listenPort = 51820; # 21841 for client

        peers = [{
          # server: client public key. client: server public key
          publicKey = ''
            AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
          '';
          allowedIPs =
            [ "0.0.0.0/0" ]; # server: 192.168.2.2/32, client: 192.168.2.0/24
          # endpoint = server-ip:51820; # client only
        }];

        # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
        # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
        '';

        # This undoes the above command
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
        '';

        ############
        # DEFAULTS #
        ############

        # useNetworkd = config.networking.useNetworkd;

        # table = "main";
        # type = "wireguard"; # or "amneziawg"
        # socketNamespace = null; # "container";

        # preSetup = ""; # "${pkgs.iproute2}/bin/ip netns add foo";
        # preShutdown = ""; # "${pkgs.iproute2}/bin/ip netns del foo"
        # postShutdown = ""; # "${pkgs.openresolv}/bin/resolvconf -d wg0";
        # postSetup = ""; # ''printf "nameserver 10.200.100.1" | ${pkgs.openresolv}/bin/resolvconf -a wg0 -m 0'';

        # mtu = null; # 1280;
        # metric = null; # 700;
        # interfaceNamespace = null; # "init";
        # fwMark = null; # "0x6e6978";
        # allowedIPsAsRoutes = true;
        # dynamicEndpointRefreshSeconds = 0; # 300

        # extraOptions = {
        #   H4 = 12345;
        #   Jc = 5;
        #   Jmax = 42;
        #   Jmin = 10;
        #   S1 = 60;
        #   S2 = 90;
        # };

        # peers = [{
        #   publicKey = "xTIBA5rboUvnH4htodjb6e697QjLERt1NAB4mZqp8Dg=";
        #   presharedKeyFile = null; # "/private/wireguard_psk";
        #   presharedKey = null; # "rVXs/Ni9tu3oDBLS4hOyAUAa1qTWVA3loR8eL20os3I=";
        #   persistentKeepalive = null; # 25;
        #   name = publicKey; # "bernd";
        #   endpoint = null; # "demo.wireguard.io:12913";
        #   dynamicEndpointRefreshSeconds = config.networking.wireguard.interfaces.<name>.dynamicEndpointRefreshSeconds; # 5;
        #   dynamicEndpointRefreshRestartSeconds = null; # 5;
        #   allowedIPs = [ "10.192.122.3/32" ];
        # }];
      };
    };
  };
}
