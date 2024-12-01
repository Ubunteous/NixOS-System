{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.user.visual_art;

  # use opentabledriver vs xsetwacom+wacom table finder
  cfgwacom = config.user.visual_art.wacom_kernel;

  graphicpkgs = with pkgs; [ aseprite darktable krita gimp ];

  usercfg = config.user;
in {
  options.user.visual_art = {
    enable = mkEnableOption
      "Add visual art tools (wacom and apps for drawing/pictures)";
    wacom_kernel = mkEnableOption
      "Support OSS driver rather than official wacom kernel module";
  };

  config = mkIf (usercfg.enable && cfg.enable) (mkMerge [
    (mkIf (cfgwacom) {
      # provides xsetwacom command
      users.users.${user}.packages = with pkgs; [ wacomtablet ] ++ graphicpkgs;

      services = {
        xserver = {
          wacom.enable = true;
          # Note: use these to improve this:
          # - Change active area aspect ration to match monitor resolution 
          # - Change pressure sensitivity to save nibs
          # - Rotate the tablet to get the button on the correct side

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
    (mkIf (!cfgwacom) {
      users.users.${user}.packages = with pkgs; graphicpkgs;

      hardware.opentabletdriver = {
        enable = true;
        daemon.enable = true;

        # blacklistedKernelModules = [
        # 	"hid-uclogic"
        # 	"wacom"
        # ];
      };
    })
  ]);
}
