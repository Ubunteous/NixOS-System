{ config, lib, ... }:

with lib;
let
  cfg = config.wm.qtile;
  wmcfg = config.wm;
in {
  options.wm.qtile = {
    enable = mkEnableOption
      "Enables support for the Qtile windows manager (also exists as a Wayland compositor)";
  };

  config = mkIf (wmcfg.enable && cfg.enable) {

    # nixpkgs.overlays = [
    #   (final: prev: {
    #     qtile-unwrapped = prev.qtile-unwrapped.overrideAttrs (new: old: {
    #       passthru.providedSessions = [ "qtile" "qtile-wayland" ];
    #       postPatch = old.postPatch + ''
    #         mkdir -p $out/share/wayland-sessions
    #         mkdir -p $out/share/xsessions
    #         install resources/qtile.desktop -Dt $out/share/xsessions
    #         install resources/qtile-wayland.desktop -Dt $out/share/wayland-sessions
    #       '';
    #     });
    #   })
    # ];

    services.xserver.windowManager.qtile = {
      enable = true;

      # configFile = "$XDG_CONFIG_HOME/qtile/config.py"

      # extraPackages = python3Packages: with python3Packages; [
      #   qtile
      #   qtile-extras
      # ];

      # either x11 or wayland. check with echo $XDG_SESSION_TYPE
      backend = config.wm.display_backend;
    };
  };
}
