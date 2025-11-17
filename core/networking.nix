{ config, lib, ... }:

with lib;
let
  cfg = config.core.networking;
  corecfg = config.core;
in {
  options.core.networking = {
    enable = mkEnableOption "Enables support for networking";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    ##################
    #   NETWORKING   #
    ##################

    networking = {
      hostName = "nixos"; # Define your hostname.

      # syncthing needs advanced > gui > skip insecure skip hostcheck
      # see: https://docs.syncthing.net/users/faq.html#why-do-i-get-host-check-error-in-the-gui-api
      # extraHosts = ''
      #   127.0.0.1 lab
      #   ::1 lab
      # '';

      # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # proxy.default = "http://user:password@proxy:port/";
      # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Enable networking with networkmanager (use it with nmtui)
      networkmanager.enable = true;

      firewall = {
        enable = true; # defaults to true

        # # to find relevant ports, use netstat -lnp or journalctl -k
        # # use this to figure out which ports where blocked when actually needed
        # logRefusedConnections = true;

        # interfaces = "";

        # # use iptables/ip6tables commands
        # extraCommands = ''
        #   iptables -A nixos-fw -p tcp --source 192.0.2.0/24 --dport 1714:1764 -j nixos-fw-accept || true
        #   iptables -A nixos-fw -p udp --source 192.0.2.0/24 --dport 1714:1764 -j nixos-fw-accept || true
        # '';

        # # sometimes, rules removed by extraStopCommands don’t match the ones added by extraCommands
        # # (e.g.: systemd unit failure to reach rules location)
        # # If that happens, the teardown will fail to happen cleanly.
        # # Prevent it by making the extraStopCommands idempotent by appending || true
        # extraStopCommands = ''
        #   iptables -D nixos-fw -p tcp --source 192.0.2.0/24 --dport 1714:1764 -j nixos-fw-accept || true
        #   iptables -D nixos-fw -p udp --source 192.0.2.0/24 --dport 1714:1764 -j nixos-fw-accept || true
        # '';

        # extraCommands = "";
        # extraInputRules = "ip6 saddr { fc00::/7, fe80::/10 } tcp dport 24800 accept";
        # extraForwardRules = "iifname wg0 accept";

        # Open ports in the firewall. Alternative: allowedTCP/UDPPortsRanges
        allowedTCPPorts = [ 22 80 ]; # HTTPS on 443
        # allowedUDPPorts = [ 53 ];

        # try https firefox, nmtui, synthing and homepage

        # # interface specific rule
        # interfaces."eth0".allowedTCPPorts = [ 80 443 ];
      };
    };
  };
}
