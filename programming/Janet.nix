{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.janet;
  langcfg = config.languages;
in {
  options.languages.janet = {
    enable =
      mkEnableOption "Enables support for the Janet programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = { packages = with pkgs; [ janet jpm ]; };
  };
}
