{ config, lib, ... }:

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

        settings = {
          # "mail.spellcheck.inline" = false; # added user.js

          # Disable remote content
          "mailnews.message_display.disable_remote_image" = true;

          # Startpage
          "mailnews.start_page.enabled" = true;

          # E2EE stuff
          "mail.e2ee.auto_enable" = true;
          "mail.e2ee.auto_disable" = true;

          # Spam
          "mail.spam.manualMark" = true;
          "mail.spam.markAsReadOnSpam" = true;
          "mail.server.default.purgeSpam" = true;
          "mail.server.default.purgeSpamInterval" = 14;
          "browser.download.enable_spam_prevention" = true;

          # Enable search integration
          "searchintegration.enabled" = true;

          # disable UI instrumentation
          "mail.instrumentation.postUrl" = "";
          "mail.instrumentation.askUser" = false;
          "mail.instrumentation.userOptedIn" = false;

          # TODO: these are mostly shared with Firefox:

          # Use BeaconDB location services
          "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";

          # Disable Telemetry
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;

          # Disable Telemetry Coverage
          "toolkit.coverage.opt-out" = true;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";

          # Disable ping center telemetry
          "browser.ping-centre.telemetry" = false;

          # Disable Normandy
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";

          # Privacy
          "privacy.donottrackheader.enabled" = true;
          "privacy.clearOnShutdown.cache" = true;

          # Disable addon suggestions
          "extensions.getAddons.showPane" = false;

          # Use XDG desktop portals
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          "widget.use-xdg-desktop-portal.location" = 1;
          "widget.use-xdg-desktop-portal.mime-handler" = 1;
          "widget.use-xdg-desktop-portal.open-uri" = 1;
          "widget.use-xdg-desktop-portal.settings" = 1;
        };

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
