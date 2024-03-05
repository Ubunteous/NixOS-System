{ config, lib, ... }:

with lib;
let
  cfg = config.me.kmonad;
in
{
  options.me.kmonad = {
    enable = mkEnableOption "Enables support for KMonad";
  };

  config = mkIf cfg.enable {

    # services.kmonad does not exist without the kmonad module
    services.kmonad = {
      enable = true; 

      # broken in v22.11
      # keyboards."laptop" = {
      #   device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";

      #   config = "../files/keyboard/kmonad.kbd";
      # };
      
      # broken in v22.11
      # keyboards = {
      #   "laptop" = {
      #     defcfg = {
      #       enable = true;
      #       compose.key = null;
      #     };

      #     device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
      #     config = builtins.readFile ../files/keyboard/kmonad.kbd;
      #   };
      # };
    };

    # services.udev.extraRules = ''
    #       # KMonad user access to /dev/uinput
    #       KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    #     '';
  };
}

  #----------------#
  #      USERS     #
  #----------------#

  # users.groups = { uinput = {}; };
  # users.extraUsers.userName = {
  #   ...
  #     extraGroups = [ ... "input" "uinput" ];
  # };
