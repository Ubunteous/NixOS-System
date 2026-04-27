{ config, lib, ... }:

with lib;
let
  cfg = config.lab.openvpn;
  labcfg = config.lab;
in {
  options.lab.openvpn = {
    enable = mkEnableOption "Enables support for openvpn";
  };

  config = mkIf (labcfg.enable && cfg.enable) {

    services.openvpn = {
      # enable = true; # no longer has an effect

      # package = pkgs.openvpn;
      # restartAfterSleep = true;

      servers = {
        server = {
          config = ''
            # Simplest server configuration: https://community.openvpn.net/openvpn/wiki/StaticKeyMiniHowto
            # server :
            dev tun
            ifconfig 10.8.0.1 10.8.0.2
            secret /root/static.key
          '';
          up = "ip route add ...";
          down = "ip route del ...";
        };

        client = {
          config = ''
            client
            remote vpn.example.org
            dev tun
            proto tcp-client
            port 8080
            ca /root/.vpn/ca.crt
            cert /root/.vpn/alice.crt
            key /root/.vpn/alice.key
          '';

          # autoStart = true;
          # updateResolvConf = false; # use a script to update resolv.conf
          # authUserPass # credentials. either an attribute set (insecure) or filepath (containing two lines)

          # # shell commands executed on startup/shutdow
          # up = "echo nameserver $nameserver | ${pkgs.openresolv}/sbin/resolvconf -m 0 -a $dev";
          # down = "${pkgs.openresolv}/sbin/resolvconf -d $dev";
        };
      };
    };
  };
}
