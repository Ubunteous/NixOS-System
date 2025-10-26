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

    networking = {
      # defaultGateway = {
      #   address = "192.0.2.1";
      #   interface = "ap0";
      # };

      # <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel => state DOWN
      # <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue => state UP

      # ap0 goes down but create_ap makes its own to work anyway
      interfaces.ap0 = {
        virtual = true;
        ipv4.addresses = [{
          address = "192.168.12.1";
          prefixLength = 24;
        }];
      };
    };

    services.create_ap = {
      enable = true;

      settings = {
        INTERNET_IFACE = "ap0";
        WIFI_IFACE = "wlp1s0";
        SSID = "Hotspot";
        PASSPHRASE = "testtest";
      };
    };
  };
}
