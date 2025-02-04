{ config, lib, ... }:

with lib;
let
  cfg = config.lab.adguard;
  labcfg = config.lab;
in {

  options.lab.adguard = {
    enable = mkEnableOption "Enables support for adguard";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.adguardhome = {
      enable = true;

      settings = {
        # http = { address = "127.0.0.1:3000"; };

        dns = {
          upstream_dns = [
            # # Example config with quad9
            # "9.9.9.9#dns.quad9.net"
            # "149.112.112.112#dns.quad9.net"

            # # default
            # "https://dns10.quad9.net/dns-query"

            # Unbound
            "127.0.0.1:5335"
          ];
        };

        filtering = {
          protection_enabled = true;
          filtering_enabled = true;

          parental_enabled = false;
          safe_search.enabled = false;
        };

        filters = map (url: {
          enabled = true;
          url = url;
        }) [
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt" # list of Hacked Malware Web Sites
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
        ];
      };

      # extraArgs = [];
      # allowDHCP = config.services.adguardhome.settings.dhcp.enabled or false

      openFirewall = true;

      # allow changes on the web interface to be saved
      # mutableSettings = false;

      # port = 3090; # defaults to 3000
      # host = "127.0.0.1"; # defaults to "0.0.0.0";
    };
  };
}
