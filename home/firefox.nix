{ osConfig, config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.firefox;
  cfgext = config.home.firefox.on-nixos;
  homecfg = config.home;

  # mkIfElse = p: yes: no: mkMerge [ (mkIf p yes) (mkIf (!p) no) ];

  firefox-addons = with pkgs.nur.repos.rycee.firefox-addons; [
    ublock-origin
    darkreader
    tridactyl
    ublock-origin
    istilldontcareaboutcookies
    # tab-stash
    # multi-account-containers
  ];
in {
  options.home.firefox = {
    enable = mkEnableOption "Enable support for Firefox";
    on-nixos = mkEnableOption
      "Whether the configuration is hosted on nixos (for plugin support)";
    # extsystem = mkOption {
    #   description = "Platform on which firefox extensions will be installed";
    #   default = null; # null, "nix" or "nixos"
    #   type = types.enum [ "nixos" "home-manager" ];
    # };
  };

  # config = mkIf (homecfg.enable && (cfg.enable || cfghm.enable))
  config = mkIf (homecfg.enable && cfg.enable) (mkMerge [{
    ###############
    #   FIREFOX   #
    ###############

    # HANDLE MANUALLY:
    # + Firefox theme: dark theme by унечтожитель or Noctourniquet
    # + Enable extensions
    # + In about:preferences set 120%-133% zoom by default
    # + about:config may contain interesting parameters

    # this does not work => option unknown. Try option -b
    # rewrite search.json.mozlz4 even if firefox messes with it
    # xdg.configFile."search.json.mozlz4".force = true;
    # home.file."foo/search.json.mozlz4".force = true;

    programs.firefox = {
      enable = true;

      profiles.default = {
        extensions = if cfgext then
          with osConfig; firefox-addons
        else
          with config; firefox-addons;

        id = 0; # each profile have a unique number (n > 0)
        name = "Default";
        isDefault = true;

        # default = "DuckDuckGo";
        search.default = "CustomDuckDuckGo";

        # systematically delete search.json.mozlz4 to prevent home manager conflict with files in the way
        search.force = true;

        search.engines = {
          # Url with DuckDuckGo preferences
          # Sometimes conflicts with .mozilla/firefox/default/search.json.mozlz4
          "CustomDuckDuckGo".urls = [{
            template =
              "https://duckduckgo.com/?ks=s&k7=24273a&kae=d&kj=24273a&k9=8bd5ca&kaa=f5a97f&k21=363a4f&k1=-1&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kau=-1&q={searchTerms}";
          }];

          # Direct access to nix options with prefix @np
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];

            definedAliases = [ "@np" ];
          };

          # Direct access to nix options with prefix @no
          "Nix Options" = {
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                # I expected the value to be options. weird but that's how the site is
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];

            definedAliases = [ "@no" ];
          };

          # Direct access to home manager options with prefix @hm
          "Home Manager" = {
            urls = [{
              template =
                "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
              # "https://mipmip.github.io/home-manager-option-search/?query={searchTerms}";
            }];

            definedAliases = [ "@hm" ];
          };
        };

        # note: browser.startup.homepage can point to a local html file
        # settings stored in prefs.js (like extraconfig = ...)
        settings = {
          "browser.urlbar.placeholderName" = "This is were the fun begins";

          # GENERAL
          "browser.startup.page" = 3; # session restore
          "browser.ctrlTab.sortByRecentlyUsed" = true;
          # optional: appearance dark
          "font.size.variable.x-western" = 24; # font size. breaks some websites
          # default zoom => in external database. change manually
          "browser.fullscreen.autohide" =
            false; # do not hide tabs when fullscreen
          "layout.css.devPixelsPerPx" = "1.25"; # zoom tabs/search bar

          # HOME
          # "browser.startup.homepage" = "https://nixos.org";
          "browser.newtabpage.activity-stream.feeds.topsites" = false;

          # DEVTOOLS
          "devtools.dom.enabled" = true;

          # PRIVACY AND SECURITY
          "privacy.donottrackheader.enabled" = true;
          "signon.rememberSignons" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "permissions.default.geo" = 2;
          "app.shield.optoutstudies.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "pdfjs.enableScripting" = false; # pdf security

          # MISC (about:config)
          "browser.aboutConfig.showWarning" = false;
          "browser.tabs.closeWindowWithLastTab" = false;
          # "toolkit.cosmeticAnimations.enabled" = false; # disable website animations
          # "browser.search.openintab" = true;
          # "layout.spellcheckDefault" = 2; # 0 = no highlighting. 1-5 different (like dots/lines)
          # "browser.tabs.insertRelatedAfterCurrent" = false;
          "media.autoplay.enabled" = false;
          # "browser.display.background_color" = "#F9F9FA"; # also try ededf0, d7d7db
          "toolkit.zoomManager.zoomValues" =
            ".5,.75,1,1.25,1.5,1.75,2"; # default: .3,.5,.67,.8,.9,1,1.1,1.2,1.33,1.5,1.7,2,2.4,3,4,5

          # no bell sound
          "accessibility.typeaheadfind.enablesound" = false;
          "accessibility.typeaheadfind.soundURL" = "";

          # MORE OPTIONS AT: https://github.com/arkenfox/user.js

          ########################
          #   SECTION: FASTFOX   #
          ########################

          # # GENERAL
          # "content.notify.interval" = 100000;

          # # GFX
          # "gfx.canvas.accelerated.cache-items" = 4096;
          # "gfx.canvas.accelerated.cache-size" = 512;
          # "gfx.content.skia-font-cache-size" = 20;

          # # DISK CACHE
          # "browser.cache.jsbc_compression_level" = 3;

          # # MEDIA CACHE
          # "media.memory_cache_max_size" = 65536;
          # "media.cache_readahead_limit" = 7200;
          # "media.cache_resume_threshold" = 3600;

          # # IMAGE CACHE
          # "image.mem.decode_bytes_at_a_time" = 32768;

          # # NETWORK
          # "network.http.max-connections" = 1800;
          # "network.http.max-persistent-connections-per-server" = 10;
          # "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          # "network.http.pacing.requests.enabled" = false;
          # "network.dnsCacheExpiration" = 3600;
          # "network.dns.max_high_priority_threads" = 8;
          # "network.ssl_tokens_cache_capacity" = 10240;

          # # SPECULATIVE LOADING
          # "network.dns.disablePrefetch" = true;
          # "network.prefetch-next" = false;
          # "network.predictor.enabled" = false;

          # # EXPERIMENTAL
          # "layout.css.grid-template-masonry-value.enabled" = true;
          # "dom.enable_web_task_scheduling" = true;
          # "layout.css.has-selector.enabled" = true;
          # "dom.security.sanitizer.enabled" = true;

          #######################
          #   SECURE: FASTFOX   #
          #######################

          # # TRACKING PROTECTION
          # "browser.contentblocking.category" = "strict";
          # "urlclassifier.trackingSkipURLs" = "*.reddit.com = *.twitter.com = *.twimg.com = *.tiktok.com";
          # "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com = *.twitter.com = *.twimg.com";
          # "network.cookie.sameSite.noneRequiresSecure" = true;
          # "browser.download.start_downloads_in_tmp_dir" = true;
          # "browser.helperApps.deleteTempFileOnExit" = true;
          # "browser.uitour.enabled" = false;
          # "privacy.globalprivacycontrol.enabled" = true;

          # # OCSP & CERTS / HPKP
          # "security.OCSP.enabled" = 0;
          # "security.remote_settings.crlite_filters.enabled" = true;
          # "security.pki.crlite_mode" = 2;

          # # SSL / TLS
          # "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          # "browser.xul.error_pages.expert_bad_cert" = true;
          # "security.tls.enable_0rtt_data" = false;

          # # DISK AVOIDANCE
          # "browser.privatebrowsing.forceMediaMemoryCache" = true;
          # "browser.sessionstore.interval" = 60000;

          # # SHUTDOWN & SANITIZING
          # "privacy.history.custom" = true;

          # # SEARCH / URL BAR
          # "browser.search.separatePrivateDefault.ui.enabled" = true;
          # "browser.urlbar.update2.engineAliasRefresh" = true;
          # "browser.search.suggest.enabled" = false;
          # "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          # "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          # "browser.formfill.enable" = false;
          # "security.insecure_connection_text.enabled" = true;
          # "security.insecure_connection_text.pbmode.enabled" = true;
          # "network.IDN_show_punycode" = true;

          # # HTTPS-FIRST POLICY
          # "dom.security.https_first" = true;
          # "dom.security.https_first_schemeless" = true;

          # # PASSWORDS
          # "signon.formlessCapture.enabled" = false;
          # "signon.privateBrowsingCapture.enabled" = false;
          # "network.auth.subresource-http-auth-allow" = 1;
          # "editor.truncate_user_pastes" = false;

          # # MIXED CONTENT + CROSS-SITE
          # "security.mixed_content.block_display_content" = true;
          # "security.mixed_content.upgrade_display_content" = true;
          # "security.mixed_content.upgrade_display_content.image" = true;
          # "pdfjs.enableScripting" = false;
          # "extensions.postDownloadThirdPartyPrompt" = false;

          # # HEADERS / REFERERS
          # "network.http.referer.XOriginTrimmingPolicy" = 2;

          # # CONTAINERS
          # "privacy.userContext.ui.enabled" = true;

          # # WEBRTC
          # "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          # "media.peerconnection.ice.default_address_only" = true;

          # # SAFE BROWSING
          # "browser.safebrowsing.downloads.remote.enabled" = false;

          # # MOZILLA
          # "permissions.default.desktop-notification" = 2;
          # "permissions.default.geo" = 2;
          # "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          # "permissions.manager.defaultsUrl" = "";
          # "webchannel.allowObject.urlWhitelist" = "";

          # # TELEMETRY
          # "datareporting.policy.dataSubmissionEnabled" = false;
          # "datareporting.healthreport.uploadEnabled" = false;
          # "toolkit.telemetry.unified" = false;
          # "toolkit.telemetry.enabled" = false;
          # "toolkit.telemetry.server" = "data:,";
          # "toolkit.telemetry.archive.enabled" = false;
          # "toolkit.telemetry.newProfilePing.enabled" = false;
          # "toolkit.telemetry.shutdownPingSender.enabled" = false;
          # "toolkit.telemetry.updatePing.enabled" = false;
          # "toolkit.telemetry.bhrPing.enabled" = false;
          # "toolkit.telemetry.firstShutdownPing.enabled" = false;
          # "toolkit.telemetry.coverage.opt-out" = true;
          # "toolkit.coverage.opt-out" = true;
          # "toolkit.coverage.endpoint.base" = "";
          # "browser.ping-centre.telemetry" = false;
          # "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          # "browser.newtabpage.activity-stream.telemetry" = false;

          # # EXPERIMENTS
          # "app.shield.optoutstudies.enabled" = false;
          # "app.normandy.enabled" = false;
          # "app.normandy.api_url" = "";

          # # CRASH REPORTS
          # "breakpad.reportURL" = "";
          # "browser.tabs.crashReporting.sendReport" = false;
          # "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

          # # DETECTION
          # "captivedetect.canonicalURL" = "";
          # "network.captive-portal-service.enabled" = false;
          # "network.connectivity-service.enabled" = false;

          #########################
          #   SECTION: PESKYFOX   #
          #########################

          # # MOZILLA UI
          # "browser.privatebrowsing.vpnpromourl" = "";
          # "extensions.getAddons.showPane" = false;
          # "extensions.htmlaboutaddons.recommendations.enabled" = false;
          # "browser.discovery.enabled" = false;
          # "browser.shell.checkDefaultBrowser" = false;
          # "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          # "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          # "browser.preferences.moreFromMozilla" = false;
          # "browser.tabs.tabmanager.enabled" = false;
          # "browser.aboutConfig.showWarning" = false;
          # "browser.aboutwelcome.enabled" = false;

          # # THEME ADJUSTMENTS
          # "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          # "browser.compactmode.show" = true;
          # "browser.display.focus_ring_on_anything" = true;
          # "browser.display.focus_ring_style" = 0;
          # "browser.display.focus_ring_width" = 0;
          # "layout.css.prefers-color-scheme.content-override" = 2;
          # "browser.privateWindowSeparation.enabled" = false; // WINDOWS

          # # COOKIE BANNER HANDLING
          # "cookiebanners.service.mode" = 1;
          # "cookiebanners.service.mode.privateBrowsing" = 1;

          # # FULLSCREEN NOTICE
          # "full-screen-api.transition-duration.enter" = "0 0";
          # "full-screen-api.transition-duration.leave" = "0 0";
          # "full-screen-api.warning.delay" = -1;
          # "full-screen-api.warning.timeout" = 0;

          # # URL BAR
          # "browser.urlbar.suggest.calculator" = true;
          # "browser.urlbar.unitConversion.enabled" = true;
          # "browser.urlbar.trending.featureGate" = false;

          # # NEW TAB PAGE
          # "browser.newtabpage.activity-stream.feeds.topsites" = false;
          # "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

          # # POCKET
          # "extensions.pocket.enabled" = false;

          # # DOWNLOADS
          # "browser.download.always_ask_before_handling_new_types" = true;
          # "browser.download.manager.addToRecentDocs" = false;

          # # PDF
          # "browser.download.open_pdf_attachments_inline" = true;

          # # TAB BEHAVIOR
          # "browser.bookmarks.openInTabClosesMenu" = false;
          # "browser.menu.showViewImageInfo" = true;
          # "findbar.highlightAll" = true;
          # "layout.word_select.eat_space_to_next_word" = false;

          ##########################
          #   SECTION: SMOOTHFOX   #
          ##########################

          # // USE ONLY ONE OPTION AT A TIME!

          ###################################
          #   OPTION 1: SHARPEN SCROLLING   #
          ###################################

          # "apz.overscroll.enabled" = true; // DEFAULT NON-LINUX
          # "mousewheel.min_line_scroll_amount" = 10; // 10-40; adjust this number to your liking; default=5
          # "general.smoothScroll.mouseWheel.durationMinMS" = 80; // default=50
          # "general.smoothScroll.currentVelocityWeighting" = 0.15; // default=.25
          # "general.smoothScroll.stopDecelerationWeighting" = 0.6; // default=.4

          ###################################
          #   OPTION 2: INSTANT SCROLLING   #
          ###################################

          # // recommended for 60hz+ displays
          # "apz.overscroll.enabled" = true; // DEFAULT NON-LINUX
          # "general.smoothScroll" = true; // DEFAULT
          # "mousewheel.default.delta_multiplier_y" = 275; // 250-400; adjust this number to your liking

          ##################################
          #   OPTION 3: SMOOTH SCROLLING   #
          ##################################

          # // recommended for 90hz+ displays
          # "apz.overscroll.enabled" = true; // DEFAULT NON-LINUX
          # "general.smoothScroll" = true; // DEFAULT
          # "general.smoothScroll.msdPhysics.enabled" = true;
          # "mousewheel.default.delta_multiplier_y" = 300; // 250-400; adjust this number to your liking

          ##########################################
          #   OPTION 4: NATURAL SMOOTH SCROLLING   #
          ##########################################

          # // recommended for 120hz+ displays
          # // largely matches Chrome flags: Windows Scrolling Personality and Smooth Scrolling
          # "apz.overscroll.enabled" = true; // DEFAULT NON-LINUX
          # "general.smoothScroll" = true; // DEFAULT
          # "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
          # "general.smoothScroll.msdPhysics.enabled" = true;
          # "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
          # "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
          # "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
          # "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 2.0;
          # "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
          # "general.smoothScroll.currentVelocityWeighting" = 1.0;
          # "general.smoothScroll.stopDecelerationWeighting" = 1.0;
          # "mousewheel.default.delta_multiplier_y" = 300; // 250-400; adjust this number to your liking	    
        };
      };
    };
  }

    # more recent version further improved with if/else
    # (mkIfElse (cfgext) {
    #   programs.firefox.profiles.default.extensions = with osConfig; fox-addons;
    # } {
    #   programs.firefox.profiles.default.extensions = with config; fox-addons;
    # })

    # # find a way later to merge both list around a with osConfig/config condition
    # (mkIfElse (cfgext) {
    #   programs.firefox.profiles.default.extensions =
    #     with osConfig.nur.repos.rycee.firefox-addons; [
    #       darkreader
    #       tridactyl
    #       ublock-origin
    #       istilldontcareaboutcookies
    #       tab-stash
    #       # multi-account-containers
    #     ];
    # } {
    #   programs.firefox.profiles.default.extensions =
    #     with config.nur.repos.rycee.firefox-addons; [
    #       darkreader
    #       tridactyl
    #       ublock-origin
    #       istilldontcareaboutcookies
    #     ];
    # })
    # # find a way later to merge both list around a with osConfig/config condition
    # (mkIfElse (cfgext) {
    #   programs.firefox.profiles.default.extensions =
    #     with osConfig.nur.repos.rycee.firefox-addons; [
    #       darkreader
    #       tridactyl
    #       ublock-origin
    #       istilldontcareaboutcookies
    #       tab-stash
    #       # multi-account-containers
    #     ];
    # } {
    #   programs.firefox.profiles.default.extensions =
    #     with config.nur.repos.rycee.firefox-addons; [
    #       darkreader
    #       tridactyl
    #       ublock-origin
    #       istilldontcareaboutcookies
    #     ];
    # })

    # tridactyl main changes:
    # bind m scrollpx -10
    # bind i scrollpx 10
    # bind n scrollline 10
    # bind e scrollline -10
    # unbind <C-f>
  ]);
}
