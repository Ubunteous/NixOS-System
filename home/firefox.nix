{ config, pkgs, home-manager, user, ... }:

###############
#   FIREFOX   #
###############

# HANDLE MANUALLY:
# + Firefox theme: dark theme by унечтожитель or Noctourniquet
# + I still don't care about cookies
# + Enable extensions
# + In about:preferences set 120%-133% zoom by default
# + about:config may contain interesting parameters

{
  home-manager.users.${user} = {
    # this does not work => option unknown. Try option -b
    # rewrite search.json.mozlz4 even if firefox messes with it
    # xdg.configFile."search.json.mozlz4".force = true;
    # home.file."foo/search.json.mozlz4".force = true;
      
    programs.firefox = {
      enable = true;
      
      profiles.default = {
        id = 0; # each profile have a unique number (n > 0)
        name = "Default";
        isDefault = true;

        # default = "DuckDuckGo";
        search.default = "CustomDuckDuckGo";

        extensions = with pkgs; [
          config.nur.repos.rycee.firefox-addons.darkreader
          config.nur.repos.rycee.firefox-addons.tridactyl
          config.nur.repos.rycee.firefox-addons.ublock-origin
          # config.nur.repos.rycee.firefox-addons.violentmonkey
        ];

        # systematically delete search.json.mozlz4 to prevent home manager conflict with files in the way
        search.force = true;

        search.engines = {
          # Url with DuckDuckGo preferences
          # Sometimes conflicts with .mozilla/firefox/default/search.json.mozlz4
          "CustomDuckDuckGo".urls = [{ template = "https://duckduckgo.com/?ks=s&k7=24273a&kae=d&kj=24273a&k9=8bd5ca&kaa=f5a97f&k21=363a4f&k1=-1&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kau=-1&q={searchTerms}"; }];
          
          # Direct acces to nix packages with prefix @np
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            
            definedAliases = [ "@np" ];
          };
        };

        # settings stored in prefs.js (like extraconfig = ...)
        settings = {
          "browser.urlbar.placeholderName" = "This is were the fun begins";

          # GENERAL
          "browser.startup.page" = 3; # session restore
          "browser.ctrlTab.sortByRecentlyUsed" = true;
          # optional: appearance dark
          "font.size.variable.x-western" = 24; # font size
          # default zoom => in external database. change manually

          # HOME
          # "browser.startup.homepage" = "https://nixos.org";
          "browser.newtabpage.activity-stream.feeds.topsites" = false;

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
          "toolkit.zoomManager.zoomValues" = ".5,.75,1,1.25,1.5,1.75,2"; # default: .3,.5,.67,.8,.9,1,1.1,1.2,1.33,1.5,1.7,2,2.4,3,4,5
        };
      };
    };      
  };
}
