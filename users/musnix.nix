{ config, lib, musnix, ... }:

with lib;
let
  cfg = config.user.musnix;
  usercfg = config.user;
in
{
  options.user.musnix = {
    enable = mkEnableOption "Enables support for Musnix";
  };

  config = mkIf (usercfg.enable && cfg.enable) {
    musnix.enable = true;
    # musnix.alsaSeq.enable = true;
    # musnix.ffado.enable = true;
    # musnix.soundcardPciId = "string";

    # the following can be used without musnix.enable true
    # musnix.kernel.realtime = true;

    # Don't. It's completely buggy and loops forever 
    # musnix.kernel.packages = pkgs.linuxPackages_5_4_rt;

    # OPTIONS for kernel package:
    # pkgs.linuxPackages_5_4_rt
    # pkgs.linuxPackages_5_15_rt
    # pkgs.linuxPackages_6_0_rt
    # pkgs.linuxPackages_rt
    # pkgs.linuxPackages_latest_rt
  };
}
