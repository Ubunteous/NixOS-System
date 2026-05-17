{ config, lib, ... }:

with lib;
let
  cfg = config.lab.adguard;
  labcfg = config.lab;
  # server-address = "192.168.1.99";
in {

  options.lab.adguard = {
    enable = mkEnableOption "Enables support for adguard";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    networking.nameservers = [ "127.0.0.1" "::1" "0.0.0.0" ];

    # environment.etc = { "resolv.conf".text = "nameserver 192.168.1.17"; };

    services.adguardhome = {
      enable = true;

      # port = 3090; # defaults to 3000
      # host = "127.0.0.1"; # defaults to "0.0.0.0";
      host = "0.0.0.0";

      mutableSettings = true;
      allowDHCP = false;
      openFirewall = true;

      settings = {
        # http = { address = "127.0.0.1:3000"; };

        dns = {
          # bind_hosts = [ "127.0.0.1" "192.168.50.20" ];
          # bind_hosts = [ "127.0.0.1" ];
          # bind_hosts = [ "0.0.0.0" "192.168.1.17" ];
          bind_hosts = [ "0.0.0.0" ];

          # upstream_dns = [ "64.59.135.135" "64.59.128.112" ];
          # all_servers = true;
          # bootstrap_dns = [ "64.59.135.135" "64.59.128.112" ];

          upstream_dns = [
            # # Example config with quad9
            # "9.9.9.9#dns.quad9.net"
            # "149.112.112.112#dns.quad9.net"

            # default
            "https://dns10.quad9.net/dns-query"

            # with unbound service enabled
            # "127.0.0.1:5335"
          ];

          # all_servers = true;
          # bootstrap_dns = [ "x.x.x.x" ];
          # bind_hosts = [ "127.0.0.1" server-address ];
        };

        # filtering = {
        #   protection_enabled = true;
        #   filtering_enabled = true;

        #   parental_enabled = false;
        #   safe_search.enabled = true;

        #   # rewrites = [
        #   #   {
        #   #     domain = "*.mydomain.com";
        #   #     answer = server-address;
        #   #   }
        #   #   {
        #   #     domain = "mydomain.com";
        #   #     answer = server-address;
        #   #   }
        #   # ];
        # };

        # filters = map (url: {
        #   enabled = true;
        #   url = url;
        # }) [
        #   "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt" # list of Hacked Malware Web Sites
        #   "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
        # ];
      };

      # extraArgs = [];
    };
  };
}
