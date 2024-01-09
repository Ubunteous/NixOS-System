{ config, lib, pkgs, home-manager, user, ... }:

with lib;
let
  cfg = config.home.u-he;
in
{
  options.home.u-he = {
    enable = mkEnableOption "Enable support for u-he plugins";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      ############
      #   U-HE   #
      ############

      # You can see rofi's cache and list of desktop files in:
      # $HOME/.cache/rofi3.druncache
      # cockos-reaper.desktop
      # com.bitwig.BitwigStudio.desktop or bitwig-studio.desktop ?

      xdg.desktopEntries = {

        u-he-reaper = {
          name = "REAPER";
          genericName = "REAPER";

          # u-he dialog fix
          exec = "nix-shell .nix.d/nix-shell/u-he.nix --run reaper";

          icon = "/home/${user}/.nix.d/home/icons/Reaper Logo.png";
          terminal = false;
          type = "Application";
        };

        u-he-bitwig = {
          name = "Bitwig Studio";
          genericName = "Bitwig Studio";

          # u-he dialog fix
          exec = "nix-shell .nix.d/nix-shell/u-he.nix --run bitwig-studio";

          icon = "/home/${user}/.nix.d/home/icons/Bitwig Logo.png";
          terminal = false;
          type = "Application";
        };
      };
    };
  };
}
