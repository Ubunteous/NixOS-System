{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.core.nix-ld;
  corecfg = config.core;
in {
  options.core.nix-ld = {
    enable = mkEnableOption "Enables support for nix-ld";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    programs.nix-ld = {
      enable = true;

      # package = pkgs.nix-ld; 

      # libs automatically available to all programs (default common libs)

      # hack to run most binaries
      # libraries = pkgs.steam-run.fhsenv.args.multiPkgs pkgs;

      # libraries = with pkgs;
      #   [
      #     # imgui
      #     #   glib
      #     #   gtk3
      #   ];
    };

    # services.envfs.enable = true;
  };
}
