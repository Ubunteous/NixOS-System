{ config, user, lib, ... }:

with lib;
let
  cfg = config.lab.virtualbox;
  labcfg = config.lab;
  in {
    options.lab.virtualbox = {
      enable = mkEnableOption "Enables support for Virtualbox";
    };

    config = mkIf (labcfg.enable && cfg.enable) {
    ##################
    #   VIRTUALBOX   #
    ##################

    # NOTE: restart after adding to group (vboxusers)

    users.extraGroups.vboxusers.members = [ "${user}" "sudo" ];

    virtualisation.virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };

      # # guest was broken in 22.11
      # guest = {
      #   enable = true;
      #   x11 = true;
      # };

    };
  };
}
