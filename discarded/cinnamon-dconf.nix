{ ... }:

# requires home manager and cinnamon desktop environment
{
  # programs.dconf.enable = true;

  dconf.settings = {
    "org/cinnamon/sounds" = {
      login-enabled = false;
      logout-enabled = false;
      switch-enabled = false;
      map-enabled = false;
      close-enabled = false;
      minimize-enabled = false;
      maximize-enabled = false;
      unmaximize-enabled = false;
      tile-enabled = false;
      plug-enabled = false;
      unplug-enabled = false;
      notification-enabled = false;
    };
    "org/cinnamon/desktop/sounds" = { volume-sound-enabled = false; };
    "nemo/window-state" = { start-with-sidebar = false; };
    "org/cinnamon/settings-daemon/plugins/power" = {
      sleep-display-ac = 300;
      sleep-display-battery = 300;
      sleep-inactive-ac-timeout = 0;
      sleep-inactive-battery-timeout = 0;
      idle-dim-time = 120;
      idle-brightness = 5;
      idle-dim-battery = true;
      lid-close-suspend-with-external-monitor = false;
      lid-close-ac-action = "'nothing'";
      lid-close-battery-action = "'nothing'";
      button-power = "'interactive'";
      critical-battery-action = "'shutdown'";
      lock-on-suspend = true;
    };

    "org/cinnamon/desktop/session".idle-delay = "uint32 300";

    "org/cinnamon/desktop/screensaver" = {
      lock-enabled = true;
      lock-delay = "uint32 0";
    };
    "org/cinnamon" = {
      startup-animation = false;
      enable-vfade = false;
      desktop-effects-workspace = false;
    };

    "org/cinnamon/muffin".desktop-effects = false;
    "org/cinnamon/desktop/interface".font-name = "'Ubuntu 12'";
    "org/cinnamon/desktop/wm/preferences".theme = "'Nordic'";

    "org/cinnamon/desktop/interface" = {
      icon-theme = "'Papirus-Dark'";
      gtk-theme = "'Arc-Dark'";
    };

    "org/cinnamon/theme".name = "'Arc-Dark'";

    "org/nemo/desktop" = {
      font = "'Ubuntu 12'";
      computer-icon-visible = false;
      home-icon-visible = false;
      volumes-visible = false;
    };

    "org/cinnamon/desktop/privacy".remember-recent-files = false;
  };
}
