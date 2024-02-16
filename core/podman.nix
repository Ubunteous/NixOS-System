{ config, user, lib, ... }:

with lib;
let
  cfg = config.core.podman;
  corecfg = config.core;
in
{
  options.core.podman = {
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

      # extraPackages = with packages; [ buildah ];
    };
  };
}
