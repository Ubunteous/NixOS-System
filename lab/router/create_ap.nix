{ config, lib, ... }:

with lib;
let
  cfg = config.lab.create_ap;
  corecfg = config.lab;
in {
  options.lab.create_ap = {
    enable = mkEnableOption "Enables support for linux-wifi-hotspot";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    # networking.networkmanager.enable = lib.mkForce false; # avoid conflict

    # same as:
    # nix-shell -p linux-wifi-hotspot
    # sudo ip link add link wlp1s0 name ap0 type macvlan
    # sudo ip addr add 192.168.1.100/24 dev ap0
    # sudo ip link set dev ap0 up
    # create_ap wlp1s0 ap0 hotspot passpass

    networking = {
      #   # defaultGateway = {
      #   #   address = "192.0.2.1";
      #   #   interface = "ap0";
      #   # };

      #   # <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel => state DOWN
      #   # <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue => state UP

      # ap0 goes down but create_ap makes its own to work anyway
      interfaces.ap0 = {
        virtual = true;
        ipv4.addresses = [{
          address = "192.168.12.1";
          prefixLength = 24;
        }];
      };
    };

    # recommended for performances
    services.haveged.enable = true;

    # currently starts create_ap but downs wlp1s0
    services.create_ap = {
      enable = true;

      settings = {
        WIFI_IFACE = "wlp1s0";
        INTERNET_IFACE = "ap0";
        SSID = "Hotspot";
        PASSPHRASE = "testtest";

        # channel = 11;
      };
    };
  };
}
