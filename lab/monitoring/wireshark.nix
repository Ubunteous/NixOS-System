{
  config,
  lib,
  pkgs,
  user,
  ...
}:

with lib;
let
  cfg = config.lab.wireshark;
  labcfg = config.lab;
in
  {
	options.lab.wireshark = {
      enable = mkEnableOption "Enables support Wireshark";
	};

	config = mkIf (labcfg.enable && cfg.enable) {
    users.users.${user}.extraGroups = [ "wireshark" ];

    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
      # usbmon.enable = true; # capture usb traffic

      # allow users in wireshark group to capture netork traffic
      # dumpcap.enable = true; # defaults to true
    };
  };
}
