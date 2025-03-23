{ config, lib, ... }:

with lib;
let
  cfg = config.user.input-remapper;
  usercfg = config.user;
in {
  options.user.input-remapper = {
    enable = mkEnableOption "Enables support input-remapper";
  };

  config = mkIf (usercfg.enable && cfg.enable) {

    services.input-remapper = {
      enable = true;

      # serviceWantedBy = [ "graphical.target" ]; # "multi-user.target"
      # enableUdevRules = false; # defaults to false due to error

      # package = pkgs.input-remapper;
    };
  };
}
