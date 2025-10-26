{ config, lib, ... }:

with lib;
let
  cfg = config.lab.hostapd;
  corecfg = config.lab;

  # interface = "wlan0";
in {
  options.lab.hostapd = {
    enable = mkEnableOption "Enables support for hostapd";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    # networking.networkmanager.enable = lib.mkForce false; # avoid conflict

    networking.wlanInterfaces."wlan-ap0".device = "wlp1s0";

    networking.networkmanager.unmanaged = [ "wlan-ap0" ];
    services.haveged.enable = config.services.hostapd.enable;

    services.hostapd = {
      enable = true;
      radios = {
        wlan-ap0 = {
          # band = "2g"; # "2g" (default), "5g", "6g", "60g"
          # countryCode = "FR";
          # channel = 1; # 0 (default) for ACS. iw list shows channel<=1

          # wifi4.enable = false; # true (default)
          # wifi5.enable = false;

          networks = { # defines a BSS, colloquially known as a WiFi network
            wlan-ap0 = {
              ssid = "wifi-name";
              authentication = {
                # mode = "none"; # "none", "wpa2-sha1/256", "wpa3-sae(-transition)" (default)
                # put this in sops/agenix when use it for real
                # saePasswordsFile = null; # null or absolute path
                # wpaPassword = "passpass"; # 8-63 characters. not used with wpa3-sae
                saePasswords = [{
                  password = "PassPass";
                }

                  # Only the client with MAC-address 11:22:33:44:55:66 can use this password
                  # { password = "sekret pazzword"; mac = "11:22:33:44:55:66"; }
                ];
              };
              # bssid = "36:b9:ff:ff:ff:ff"; # normally set by default if only one needed
              # settings = { bridge = "br-lan"; };
              # settings.ieee80211n = true; # otherwise enabled by wifi4.enable

              # also check macAllow, macDeny and macAcl to authorize specific devices
            };
          };
        };
      };
    };
  };
}
