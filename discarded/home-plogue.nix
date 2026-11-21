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

  sforzando = pkgs.callPackage ../../pkgs/plogue/plogue.nix {
    name = "sforzando";
    version = "1.982";
    url = "https://sforzando.s3.us-east-1.amazonaws.com/LINUX_plogue-sforzando_1.982_x86_64.zip";
    hash = "sha256-Qcwv5DgReNxA68CWosvIwZkhDAxnc5/A15lmlc/Mr3M=";
  };
  sforzandoName = "sforzando";
  ariaBase = "${sforzando}/Plogue/Aria";
  sfzBase = "${sforzando}/Plogue/sforzando";

  ops7 = pkgs.callPackage ../../pkgs/plogue/plogue.nix {
    name = "chipsynth OPS7";
    version = "1.132";
    url = "https://s3.amazonaws.com/chipsynth/LINUX_plogue-chipsynth-ops7_1.132_x86_64.zip";
    hash = "sha256-vQXPZyc/qT+/j0KtBvS5mxgcpl/2jdQMI0Bz1p3d8xE=";
  };
  ops7NameWithSpace = "chipsynth OPS7";
  ops7Name = "chipsynth-OPS7";
  fermataBase = "${ops7}/Plogue/Fermata";
  ops7Base = "${ops7}/Plogue/chipsynth OPS7";
in
{
  options.home.music.plogue = {
    enable = lib.mkEnableOption "Plogue (including sforzando, a free SFZ 2.0 sample player)";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    # Home-manager module for plogue (including sforzando).
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
          osConfig != null && !(osConfig.programs.plogue.enable or false)
          # && !(osConfig.programs.plogue.createSymlinks or false)
        )
        "programs.plogue is enabled in home-manager but the NixOS module is not configured. plogue instruments will not run at all - add `programs.plogue.createSymlinks = true` to your NixOS configuration.";

    home.packages = [
      sforzando
      ops7
    ];

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
          product = "${sforzandoName}";
          version = 1982;
        };
        "3103" = {
          vendor = "Plogue Art et Technologie, Inc";
          product = "TableWarp2";
          version = 1982;
        };
      };
    };

    home.file.".config/Plogue/Fermata/.config".text = builtins.toJSON {
      base_dir = fermataBase;
      path = "${fermataBase}/libFermata.so";
      Products = {
        "1107" = {
          vendor = "Plogue Art et Technologie, Inc";
          product = "${ops7Name}";
          version = 1132;
        };
      };
    };

    home.file.".config/Plogue/${sforzandoName}/.config".text = builtins.toJSON {
      base_dir = sfzBase;
      # User SFZ library root — sforzando lets you change this in the GUI.
      sample_dir = "${config.home.homeDirectory}/.local/share/${sforzandoName}";
      version = 1982;
    };

    home.file.".config/Plogue/${ops7NameWithSpace}/.config".text = builtins.toJSON {
      base_dir = "${ops7Base}";
      preset_dir = "${config.home.homeDirectory}/.local/share/${ops7Name}"; # not sure if should be called preset_dir
      version = 1132;
    };

    # # Symlink plugins into standard user scan paths so no extra env vars are
    # # needed - DAWs always check ~/.vst3 and ~/.clap unconditionally.
    # home.file.".vst3/${sforzandoName}.vst3".source = "${sforzando}/lib/vst3/${sforzandoName}.vst3";
    # home.file.".clap/${sforzandoName}.clap".source = "${sforzando}/lib/clap/${sforzandoName}.clap";

    # home.file.".vst3/${ops7Name}.vst3".source = "${ops7}/lib/vst3/${ops7Name}.vst3";
    # home.file.".clap/${ops7Name}.clap".source = "${ops7}/lib/clap/${ops7Name}.clap";
  };
}
