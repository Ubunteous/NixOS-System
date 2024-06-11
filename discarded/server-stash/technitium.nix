{ config, lib, ... }:

with lib;
let
  cfg = config.lab.technitium;
  labcfg = config.lab;
  in {

    options.lab.technitium = {
      enable = mkEnableOption "Enables support for technitium DNS";
    };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.technitium-dns-server = {
      # on port 5380
      enable = true;

      # package = pkgs.technitium-dns-server;
      # openFirewall = true;
      # firewallUDPPorts = [ 53 ];
      # firewallTCPPorts = [ 443 853 ];
    };
  };
}

