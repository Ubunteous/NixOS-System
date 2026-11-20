{
  config,
  lib,
  pkgs,
  osConfig ? null,
  ...
}:

with lib;
let
  cfg = config.home.music.plogue;
  homecfg = config.home;

  sforzando = pkgs.callPackage ../../pkgs/plogue/plogue.nix { };

  ariaBase = "${sforzando}/Plogue/Aria";
  sfzBase = "${sforzando}/Plogue/sforzando";
in
{
  options.home.music.plogue = {
    enable = lib.mkEnableOption "Plogue (including sforzando, a free SFZ 2.0 sample player)";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    # Home-manager module for sforzando.
    #
    # Installs the package per-user, writes ~/.config/Plogue config files so libAria
    # finds its resources in the Nix store, and symlinks the VST3/CLAP plugins into
    # the standard user scan directories so DAWs find them without extra env vars.
    #
    # NOTE: sforzando cannot run without the system-level /opt/Plogue symlink that
    # the NixOS module creates. Enable programs.sforzando.createSymlinks = true in
    # your NixOS configuration alongside this module.

    warnings =
      lib.optional
        (
          osConfig != null
          && !(osConfig.programs.sforzando.enable or false)
          && !(osConfig.programs.sforzando.createSymlinks or false)
        )
        "programs.sforzando is enabled in home-manager but the NixOS module is not configured. sforzando will not run at all — add `programs.sforzando.createSymlinks = true` to your NixOS configuration.";

    home.packages = [ sforzando ];

    # libAria.so checks ~/.config/Plogue/Aria/.config before falling back to
    # its baked-in /opt/Plogue/Aria path, so this overrides without patching.
    home.file.".config/Plogue/Aria/.config".text = builtins.toJSON {
      base_dir = ariaBase;
      path = "${ariaBase}/libAria.so";
      Converters = {
        dls = "${ariaBase}/riff2sfz";
        sf2 = "${ariaBase}/riff2sfz";
        wav = "${ariaBase}/riff2sfz";
      };
      Products = {
        "1014" = {
          vendor = "Plogue Art et Technologie, Inc";
          product = "sforzando";
          version = 1982;
        };
        "3103" = {
          vendor = "Plogue Art et Technologie, Inc";
          product = "TableWarp2";
          version = 1982;
        };
      };
    };

    home.file.".config/Plogue/sforzando/.config".text = builtins.toJSON {
      base_dir = sfzBase;
      # User SFZ library root — sforzando lets you change this in the GUI.
      sample_dir = "${config.home.homeDirectory}/.local/share/sforzando";
      version = 1982;
    };

    # Symlink plugins into standard user scan paths so no extra env vars are
    # needed — DAWs always check ~/.vst3 and ~/.clap unconditionally.
    home.file.".vst3/sforzando.vst3".source = "${sforzando}/lib/vst3/sforzando.vst3";
    home.file.".clap/sforzando.clap".source = "${sforzando}/lib/clap/sforzando.clap";
  };
}
