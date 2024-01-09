{ config, lib, pkgs, home-manager, user, ... }:

with lib;
let
  cfg = config.home.git;
in
{
  options.home.git = {
    enable = mkEnableOption "Enable support for Git";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      ###########
      #   GIT   #
      ###########

      programs.git = {
        enable = true;
        userName  = "Ubunteous";
        # try another mail provided by git
        userEmail = "46612154+Ubunteous@users.noreply.github.com";
        # extraConfig = {
        #   core = {
        #     askPass = false;
        #   };
        # };
      };
    };
  };
}
