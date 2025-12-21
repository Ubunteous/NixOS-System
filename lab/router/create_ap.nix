{ config, lib, ... }:

with lib;
let
  cfg = config.lab.create_ap;
  corecfg = config.lab;
in {
  options.lab.create_ap = {
    enable = mkEnableOption "Enables support for linux-wifi-hotspot";
    wifiInterface = mkOption {
      description = "Wifi interface for hotspot";
      type = types.string;
    };
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    # systemd.network.netdevs is better maintained
    # networking = {
    #   interfaces.ap0 = {
    #     virtual = true;
    #     ipv4.addresses = [{
    #       address = "192.168.1.62";
    #       prefixLength = 24;
    #     }];
    #   };
    # };

    system.nixos.tags = [ "Local-Network" ];

    # recommended for performances
    services.haveged.enable = true;

    # currently starts create_ap but downs wlp1s0
    services.create_ap = {
      enable = true;

      settings = {
        WIFI_IFACE = cfg.wifiInterface;
        SSID = "Hotspot";
        PASSPHRASE = "testtest";

        CHANNEL = "default";
        GATEWAY = "192.168.12.1";
        WPA_VERSION = 2;
        ETC_HOSTS = 0;
        DHCP_DNS = "gateway";
        NO_DNS = 0;
        NO_DNSMASQ = 0;
        HIDDEN = 0;
        MAC_FILTER = 0;
        MAC_FILTER_ACCEPT = "/etc/hostapd/hostapd.accept";
        ISOLATE_CLIENTS = 0;
        SHARE_METHOD = "none";
        IEEE80211N = 0;
        IEEE80211AC = 0;
        IEEE80211AX = 0;
        # HT_CAPAB=["HT40+"];
        # VHT_CAPAB=
        # DRIVER="nl80211";
        NO_VIRT = 1; # do not use a virtual interface
        # COUNTRY=
        FREQ_BAND = "2.4";
        # NEW_MACADDR=
        DAEMONIZE = 0;
        # DAEMON_PIDFILE=
        DAEMON_LOGFILE = "/dev/null";
        # DNS_LOGFILE=
        NO_HAVEGED = 0;
        # INTERNET_IFACE=
        USE_PSK = 0;
      };
    };
  };
}
