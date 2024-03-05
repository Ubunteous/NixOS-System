{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.core.k3s;
  corecfg = config.core;
in {
  options.core.k3s = { enable = mkEnableOption "Enables support for k3s"; };

  config = mkIf (corecfg.enable && cfg.enable) {
    ###############
    #     K3S     #
    ###############

    networking.firewall.allowedTCPPorts = [
      6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
      # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
      # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
    ];

    networking.firewall.allowedUDPPorts = [
      # 8472 # k3s, flannel: required if using multi-node for inter-node networking
    ];

    services.k3s = {
      enable = true;
      role = "server";
      # extraFlags = toString [ "--kubelet-arg=v=4" ];
    };

    # environment.systemPackages = [ pkgs.k3s ]; # pkgs.k3d

    # configPath
  };
}
