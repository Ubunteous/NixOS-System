{ config, lib, ... }:

with lib;
let
  cfg = config.lab.tailscale;
  labcfg = config.lab;
in {

  options.lab.tailscale = {
    enable = mkEnableOption "Enables support for tailscale";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    # setup with:
    # sudo tailscale cert ${MACHINE_NAME}.${TAILNET_NAME}

    services.tailscale = {
      enable = true;

      # openFirewall = true;
      # authKeyFile = "/path/to/file";
      # permitCertUid = null; # "Username" or "user ID"

      # Use it by calling sudo tailscale with relevant flags like --advertise-exit-node / --exit-node
      # Client or both: reverse path filtering will be set to loose instead of strict
      # Server or both: IP forwarding will be enabled
      # Options: one of "none", "client", "server", "both"
      # useRoutingFeatures = "none";

      ###############
      #   DEFAULT   #
      ###############

      # extraUpFlags = [ "--ssh" ];
      # extraDaemonFlags = [ "--no-logs-no-support" ];

      # port = 41641;
      # package = pkgs.tailscale;
      # interfaceName = "tailscale0";
    };
  };
}
