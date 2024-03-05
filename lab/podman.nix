{ config, user, pkgs, lib, ... }:

with lib;
let
  cfg = config.lab.podman;
  corecfg = config.lab;
  in {
    options.lab.podman = {
      enable = mkEnableOption "Enables support for Podman";
    };

    config = mkIf (corecfg.enable && cfg.enable) {
    ##################
    #     PODMAN     #
    ##################

    virtualisation.podman = {
      enable = true;

      # networkSocket = {
      #   enable = true;
      #   networkSocket.tls.key
      #   tls.cert
      #   tls.cacert
      #   server
      #   port
      #   openFirewall
      #   listenAddress
      # };

      # dockerSocket.enable = true; # replace docker socket
      # defaultNetwork.settings = { dns_enabled = true;}

      # create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # extraPackages = with pkgs; [ buildah skopeo ]; # gvisor for security
    };
  };
}
