{ config, lib, ... }:

with lib;
let
  cfg = config.lab.k3s;
  labcfg = config.lab;
in {

  options.lab.k3s = { enable = mkEnableOption "Enables support for k3s"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.k3s.enable = true;

    # services.k3s.tokenFile
    # services.k3s.configPath
    # services.k3s.environmentFile

    # services.k3s.serverAddr = "https://10.0.0.10:6443";
    # services.k3s.extraFlags = "--no-deploy traefik --cluster-cidr 10.24.0.0/16";

    # services.k3s.disableAgent = true;
    # services.k3s.role = "agent"; # defaults to "server"
  };
}
