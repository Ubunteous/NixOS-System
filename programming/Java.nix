{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.java;
  langcfg = config.languages;
  in {
    options.languages.java = {
      enable =
      mkEnableOption "Enables support for the Java programming languages";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        jdk # use java/javac to run/compile
        maven # build automation tool

        jdt-language-server
        google-java-format

        # checkstyle
      ];
    };
  };
}
