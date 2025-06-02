{ config, lib, user, pkgs, ... }:

with lib;
let
  cfg = config.user.music;
  usercfg = config.user;

  callPlugin = plug_path:
    (plugin:
      (pkgs.callPackage plug_path { inherit (plugin) name url sha256; }));

  ob-xd = import ../pkgs/ob-xd/ob-xd.nix;
  tal = import ../pkgs/TAL/plugins.nix;
  callTal = plug_name: (callPlugin ../pkgs/TAL/tal.nix plug_name);

  auburn = import ../pkgs/Auburn-Sounds/plugins.nix;
  callAuburn = plug_name:
    (callPlugin ../pkgs/Auburn-Sounds/auburn-sounds.nix plug_name);

  bleedingEdgeReaper = pkgs.reaper.overrideAttrs (old: {
    version = "7.34";
    src = pkgs.fetchurl {
      url = "https://www.reaper.fm/files/7.x/reaper734_linux_x86_64.tar.xz";
      hash = "sha256-R6nFi6OPBTIJhg752o9r0lGb24VYobiaWgp5bfvFykg=";
    };
  });
in {
  options.user.music = {
    enable = mkEnableOption "Enables support for Music related software";
  };

  config = mkIf (usercfg.enable && cfg.enable) {
    users.users.${user}.packages = with pkgs; [
      #############
      #   MUSIC   #
      #############

      puddletag # music metadata
      nicotine-plus

      # config.nur.repos.dukzcry.bitwig-studio3 # version 3.1 # deleted and replaced by bitwig 5
      # bitwig-studio # latest
      # bitwig-studio3 # can be modified with overlay

      (callPackage ../pkgs/bitwig3.nix { })
      # bitwig-studio4

      # (callPackage ../pkgs/reaper.nix {
      #   jackLibrary = null;
      #   libpulseaudio = libpulseaudio; 
      # })

      ###############
      #   PLUGINS   #
      ###############

      # vital
      # helm
      # dexed
      # delayarchitect
      # chow-tape-model
      # dragonfly-reverb
      # odin2
      # surge-XT # surge with some extras
      cardinal # vcv rack as vst

      # small gui. needs to be compiled after tweaking these values:
      # ZynAddSubFXUI() : UI(1181, 659) and z.zest_resize(z.zest, width, height);
      # zynaddsubfx # zynfusion - new gui
      # lsp-plugins

      (callPackage ob-xd { })

      (callTal tal.pha)
      (callTal tal.j-8)
      (callTal tal.u-no-lx)
      (callTal tal.bassline-101)
      (callTal tal.drum)
      (callTal tal.sampler)

      # (callTal tal.mod)
      # (callTal tal.g-verb)
      # (callTal tal.dub-x)
      # (callTal tal.dac)
      # (callTal tal.filter-2)
      # (callTal tal.reverb-4)
      # (callTal tal.chorus-lx)
      # (callTal tal.noisemaker)
      # (callTal tal.vocoder)

      # (callAuburn auburn.graillon)
      # (callAuburn auburn.inner_pitch)
      # (callAuburn auburn.lens)
      # (callAuburn auburn.renegate)
      # (callAuburn auburn.panagement)
      # (callAuburn auburn.couture)

      bleedingEdgeReaper
      # reaper # see pkgs/ for reaimgui

      ############
      #   WINE   #
      ############

      # wine
      # wine64
      # wine64Packages.stagingFull # does not work yet

      # Danger with wine: default wine packages only come with 32 bits support
      # use winewow in an overlay for 64 bits support
      # Moreover, some packages are called wine64 instead of wine
      # (wine.override { wineBuild = "wine64"; })
      # (stable.wine.override { wineBuild = "wine64"; })
      # nixpkgs.overlays = [ (self: super: { wine = super.wineWowPackages.stable; }) ];
      # wine # changed with an overlay to fix it in NixOS 22.05/11
      # stable.wine
      # stable.wineWowPackages.stable
      # winetricks # useful to get gdiplus for serum

      # stable.wineWowPackages.stable
      # stable.winetricks
      # stable.yabridge
      # stable.yabridgectl

      # wineWowPackages.staging # v9.9 in 09/2024
      # wineWowPackages.staging # v9.9 in 09/2024
      wine

      winetricks
      yabridge
      yabridgectl

      # dxvk # impure. adds setup_dxvk.sh in shell

      # was necessary for native instrument
      # samba
      # samba4Full
    ];

    musnix = {
      enable = true;

      # musnix.alsaSeq.enable = true;
      # musnix.ffado.enable = true;
      # musnix.soundcardPciId = "string";

      # the following can be used without musnix.enable true
      # musnix.kernel.realtime = true;

      # Don't. It's completely buggy and loops forever 
      # musnix.kernel.packages = pkgs.linuxPackages_5_4_rt;

      # OPTIONS for kernel package:
      # pkgs.linuxPackages_5_4_rt
      # pkgs.linuxPackages_5_15_rt
      # pkgs.linuxPackages_6_0_rt
      # pkgs.linuxPackages_rt
      # pkgs.linuxPackages_latest_rt
    };

    ################
    #   OVERLAYS   #
    ################

    # necessary to fix wine
    nixpkgs.overlays = [

      ############
      #   WINE   #
      ############

      # opengl support for wine
      # hardware support for wine: hardware.opengl.driSupport32Bit

      (self: super: {
        wine = super.wineWowPackages.stable;
        stable.wine = super.wineWowPackages.stable;
      })

      ##############
      #   BITWIG   #
      ##############

      # BUG: AUDIO ENGINE CRASHING
      # (final: prev:
      #   {
      #     bitwig-studio3 = prev.bitwig-studio3.overrideAttrs (old: {
      #       version = "3.2.8";
      #       src = prev.fetchurl {
      #         url = "https://downloads.bitwig.com/stable/3.2.8/bitwig-studio-3.2.8.deb";
      #         sha256 = "18ldgmnv7bigb4mch888kjpf4abalpiwmlhwd7rjb9qf6p72fhpj";
      #       };

      #       # runtimeDependencies = [ pkgs.pulseaudio pkgs.libjack2 ];
      #     });
      #   })   
    ];
  };
}
