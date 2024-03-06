{ config, lib, ... }:

with lib;
let
  cfg = config.lab.shiori;
  labcfg = config.lab;
in {

  options.lab.shiori = {
    enable = mkEnableOption "Enables support for shiori";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.shiori = {
      enable = true;

      # webRoot = "/shiori"; # defaults to "/"
      port = 2525; # defaults to 8080
      # address = ""; # listen ip
    };
  };
}
