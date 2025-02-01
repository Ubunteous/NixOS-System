{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.core.kanata;
  corecfg = config.core;
in {
  options.core.kanata = {
    enable = mkEnableOption "Enables support for Kanata";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    services.kanata = {
      enable = true;

      # default: pkgs.kanata
      # package = pkgs.kanata-with-cmd;

      keyboards = {
        "laptop" = {
          # Paths to keyboard devices
          devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];

          config = builtins.readFile ../files/keyboard/kanata.txt;

          # defcfg conf other than linux-dev and linux-continue-if-no-devs-found (set to yes)
          # too early: concurrent-tap-hold yes
          # extraDefCfg = ''
          #   danger-enable-cmd yes      
          # '';

          # process-unmapped-keys yes
          # sequence-timeout 2000

          # visible-backspaced, hidden-suppressed or hidden-delay-type
          # sequence-input-mode visible-backspaced

          # sequence-backtrack-modcancel no
          # log-layer-changes no
          # delegate-to-first-layer yes

          # extraArgs = [ "..." ];
        };
        "kbd" = {
          devices =
            [ "/dev/input/by-id/usb-KBDfans_kbd67mkiirgb_v3-event-kbd" ];

          config = builtins.readFile ../files/keyboard/kbd67.txt;
        };
      };
    };
  };
}
