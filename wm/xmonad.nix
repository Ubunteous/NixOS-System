{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.wm.xmonad;
  wmcfg = config.wm;
in {
  options.wm.xmonad = {
    enable = mkEnableOption "Enables support for the XMonad windows manager";
  };

  config = mkIf (wmcfg.enable && cfg.enable) {
    # fix issue with java apps not displaying properly in XMonad
    environment.sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";

    # Enable the XMonad Window Manager.
    # services.xserver.displayManager.defaultSession = "none+xmonad";
    services.xserver.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages:
        with haskellPackages;
        [
          xmonad

          # haskellPackages.xmobar
          # haskellPackages.xmonad-contrib
          # haskellPackages.xmonad-extras

          # haskellPackages.taffybar # marked as broken. get taffybar instead (the one which is not part of haskellPackages)
        ];
    };
    # users.users.${user}.packages = [ pkgs.xmobar ];
  };
}
