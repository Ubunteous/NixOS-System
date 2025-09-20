{ config, lib, ... }:

with lib;
let
  cfg = config.home.u-he;
  homecfg = config.home;
in {
  options.home.u-he = {
    enable = mkEnableOption "Enable support for u-he plugins";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    ############
    #   U-HE   #
    ############

    # You can see rofi's cache and list of desktop files in:
    # $HOME/.cache/rofi3.druncache
    # cockos-reaper.desktop
    # com.bitwig.BitwigStudio.desktop or bitwig-studio.desktop ?

    xdg.desktopEntries = {
      u-he-reaper = {
        name = "REAPER (ld)";
        genericName = "REAPER (ld)";

        # u-he dialog fix
        exec = "nix-shell .nix.d/nix-shell/u-he.nix --run reaper";

        icon =
          "${config.home.homeDirectory}/.nix.d/files/icons/Reaper Logo.png";
        terminal = false;
        type = "Application";
      };

      u-he-bitwig = {
        name = "Bitwig Studio (ld)";
        genericName = "Bitwig Studio (ld)";

        # u-he dialog fix
        exec = "nix-shell .nix.d/nix-shell/u-he.nix --run bitwig-studio";

        icon =
          "${config.home.homeDirectory}/.nix.d/files/icons/Bitwig Logo.png";
        terminal = false;
        type = "Application";
      };
    };
  };
}
