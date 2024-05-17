{ config, lib, user, ... }:

with lib;
let
  cfg = config.home.mail.thunderbird;
  homecfg = config.home.mail;
in {

  options.home.mail.thunderbird = {
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
        # name = "m9";

        isDefault = true;

        # settings = { "mail.spellcheck.inline" = false; }; added user.js
        # extraConfig = ""; # added to user.js.

        # user content CSS
        # userContent = ''  /* Hide scrollbar on Thunderbird pages */  *{scrollbar-width:none !important}'';

        # withExternalGnupg = false;
      };
    };

    # OPTIONS:
    # USE DDG instead of GOOGLE
    # FONT SIZE: BIGGER (24/13)
    # UNTICK show only display name for people in my address book
    # INCOMING MAIL do not play a sound
    # SYSTEM INTEGRATION DO not check that firebird is the default

    # WEB CONTENT DO NOT SAVE COOKIES
    # DO NOT SEND TECH DATA TO MOZILLA
    # CHAT NOTIF DO NOT PLAY A SOUND

    # SORT MAIL BY DATE DESCENDING
    # VIEW DENSITY MAX
    # UI FONT

    # WHITE TEXT THEME BLACK ON BLACK background
    # Bottom of config > General > layout.css.devPixelsPerPx > 1.5

    # accounts.email = {
    #   accounts.m9 = {
    #     primary = true;

    #     # address = config.services.maildata.address;
    #     # userName = config.services.maildata.address;
    #     # realName = config.services.maildata.name;

    #     # imap.host = "imap.gmail.com";
    #     # smtp.host = "smtp.gmail.com";
    #   };
    # };

  };
}
