{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.plogue;
  plogue = pkgs.callPackage ../pkgs/plogue/plogue.nix { };
in
{
  options.programs.plogue = {
    enable = lib.mkEnableOption "Plogue (including sforzando, a free SFZ 2.0 sample player)";
  };

  config = lib.mkIf (cfg.enable) {
    # sforzando's VST3/CLAP plugins dlopen "/opt/Plogue/Aria/libAria.so" as a
    # hardcoded string — autoPatchelf can't fix string constants. Symlink the
    # Plogue tree from the nix store so the path resolves without a manual install.
    systemd.tmpfiles.rules = [
      "d /opt 0755 root root - -"
      "L+ /opt/Plogue - - - - ${plogue}/Plogue"
      # Plogue hardcodes access("/usr/bin/zenity") — ignores PATH entirely.
      "L+ /usr/bin/zenity - - - - ${pkgs.zenity}/bin/zenity"
    ];

    # zenity provides the dialog Plogue products need for license acceptance;
    # works on KDE, GNOME, and any other desktop.
    environment.systemPackages = lib.mkIf cfg.enable [
      plogue
      pkgs.zenity
    ];
  };
}
