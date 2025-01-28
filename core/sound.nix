{ config, lib, ... }:

with lib;
let
  cfg = config.core.sound;
  corecfg = config.core;
in {
  options.core.sound = {
    enable = mkEnableOption "Enables support for sound (alsa/pulse)";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    #############
    #   Sound   #
    #############

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # If you want to use JACK applications, uncomment this
      # jack.enable = true;

      # supposed to remove the bell sound
      extraConfig.pipewire = {
        "99-disable-bell" = {
          "context.properties" = { "module.x11.bell" = false; };
        };
      };

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };
}
