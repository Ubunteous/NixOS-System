{ config, lib, user, ... }:

with lib;
let
  cfg = config.mail.thunderbird;
  homecfg = config.mail;
in {

  options.mail.thunderbird = {
    enable = mkEnableOption "Enables support for thunderbird";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    programs.thunderbird = {
      enable = true;

      # settings = {
      #   "general.useragent.override" = "";
      #   "privacy.donottrackheader.enabled" = true;
      # };

      profiles."m9" = {
        name = "${user}";

        isDefault = true;

        # settings = { "mail.spellcheck.inline" = false; }; added user.js
        # extraConfig = ""; # added to user.js.

        # user content CSS
        # userContent = ''  /* Hide scrollbar on Thunderbird pages */  *{scrollbar-width:none !important}'';

        # withExternalGnupg = false;
      };
    };
  };
}
