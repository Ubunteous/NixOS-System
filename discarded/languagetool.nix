{ config, lib, user, ... }:

with lib;
let
  cfg = config.user.languagetool;
  usercfg = config.user;
in {
  options.user.languagetool = {
    enable = mkEnableOption "Enables support for Languagetool";
  };

  config = mkIf (usercfg.enable && cfg.enable) {

    services.languagetool = {
      enable = true;

      port = 8082; # 8081 already used by a pgweb

      # settings = {};
      # settings.cacheSize = 1000;
      # jvmOptions = [ "-Xmx512m" ];
    };
  };
}
