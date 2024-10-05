{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.user.wacom;

  # use opentabledriver vs xsetwacom+wacom table finder
  cfgoss = config.user.wacom.oss;

  usercfg = config.user;
in {
  options.user.wacom = {
    enable = mkEnableOption "Add Wacom tablet support";
    oss = mkEnableOption
      "Support OSS driver rather than official wacom kernel module";
  };

  config = mkIf (usercfg.enable && cfg.enable) (mkMerge [
    (mkIf (cfgoss) {
      hardware.opentabletdriver = {
        enable = true;
        daemon.enable = true;

        # blacklistedKernelModules = [
        # 	"hid-uclogic"
        # 	"wacom"
        # ];
      };
    })
    (mkIf (!cfgoss) {
      # 
      # {
      #   programs.firefox.profiles.default.extensions =
      #     with config.nur.repos.rycee.firefox-addons; [
      #       darkreader
      #       tridactyl
      #       ublock-origin
      #       istilldontcareaboutcookies
      #     ];
      # })
      # ]);

      # provides xsetwacom command
      users.users.${user}.packages = with pkgs; [ wacomtablet ];

      services = {
        xserver = {
          wacom.enable = true;

          # inputClassSections = [
          #   ''
          #     Identifier "<stylus-device-name>"
          #     MatchUSBID "<VID>:<PID>"
          #     MatchDevicePath "/dev/input/event*"
          #     MatchIsTablet "on"
          #     Driver "wacom"
          #   ''
          #   ''
          #     Identifier "<keyboard-device-name>"
          #     MatchUSBID "<VID>:<PID>"
          #     MatchDevicePath "/dev/input/event*"
          #     MatchIsKeyboard "on"
          #     Driver "libinput"
          #   ''
          # ];
        };

        # custom hotkeys
        # udev = {
        #   enable = true;

        #   extraHwdb = ''
        #     evdev:input:b<BUS-ID>v<VID>p<PID>*
        #       KEYBOARD_KEY_<HOTKEY-ID>=<KEY-SCAN-CODE>
        #       KEYBOARD_KEY_70005=a
        #       KEYBOARD_KEY_700e0=b
        #       KEYBOARD_KEY_70057=c
        #       KEYBOARD_KEY_70056=d
        #   '';
        # };
      };
    })
  ]);
}
