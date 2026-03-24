{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.kotlin;
  langcfg = config.languages;
in {
  options.languages.kotlin = {
    enable =
      mkEnableOption "Enables support for the Kotlin programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        kotlin
        jdk
        # android-studio
        # ktlint
        # detekt
        ktfmt
        kotlin-language-server
      ];
    };
  };
}
