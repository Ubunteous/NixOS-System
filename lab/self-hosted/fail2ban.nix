{ config, lib, ... }:

with lib;
let
  cfg = config.lab.fail2ban;
  labcfg = config.lab;
in {

  options.lab.fail2ban = {
    enable = mkEnableOption "Enables support for fail2ban";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.openssh.settings.logLevel = "VERBOSE";

    services.fail2ban = {
      enable = true;

      jails = {
        # apache-nohome-iptables = {
        # settings = {
        #   # Block an IP address if it accesses a non-existent
        #   # home directory more than 5 times in 10 minutes,
        #   # since that indicates that it's scanning.
        #   filter = "apache-nohome";
        #   action = ''iptables-multiport[name=HTTP, port="http,https"]'';
        #   logpath = "/var/log/httpd/error_log*";
        #   backend = "auto";
        #   findtime = 600;
        #   bantime = 600;
        #   maxretry = 5;
        # };
        # };
        dovecot = {
          settings = {
            # block IPs which failed to log-in
            # aggressive mode add blocking for aborted connections
            filter = "dovecot[mode=aggressive]";
            maxretry = 3;
          };
        };
      };

      # extraPackages = [ pkgs.ipset ];

      # ignoreIP = [
      # 	"192.168.0.0/16"
      # 	"2001:DB8::42"
      # ];

      maxretry = 5; # default to 3

      bantime-increment = {
        enable = true;
        rndtime = "20m";
        # overalljails = true;
        multipliers = "1 2 4 8 16 32 64";
        maxtime = "48h";
        # formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
        # factor = "4";
      };

      ###########
      # DEFAULT #
      ###########

      # daemonSettings = {
      # 	Definition = {
      # 	  logtarget = "SYSLOG";
      # 	  socket = "/run/fail2ban/fail2ban.sock";
      # 	  pidfile = "/run/fail2ban/fail2ban.pid";
      # 	  dbfile = "/var/lib/fail2ban/fail2ban.sqlite3";
      # 	};
      # };

      # packageFirewall = config.networking.firewall.package;

      # banaction-allports = if config.networking.nftables.enable then
      #   "nftables-allports"
      # else
      #   "iptables-allports";

      # banaction = if config.networking.nftables.enable then
      #   "nftables-multiport"
      # else
      #   "iptables-multiport";

    };
  };
}
