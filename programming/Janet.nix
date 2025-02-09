{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.janet;
  langcfg = config.languages;
  janetTreeDir = "/home/${user}/.local/share/janet/jpm_tree";

  # taken from hlissner's config (hey). enables jpm-janet interactions
  mkWrapper = package: postBuild:
    let
      name = if isList package then elemAt package 0 else package;
      paths = if isList package then package else [ package ];
    in pkgs.symlinkJoin {
      inherit paths postBuild;
      name = "${name}-wrapped";
      buildInputs = [ pkgs.makeWrapper ];
    };

  jpm = mkWrapper pkgs.jpm ''
    wrapProgram $out/bin/jpm --add-flags '--tree="$JANET_TREE" --binpath="$XDG_BIN_HOME" --headerpath=${pkgs.janet}/include --libpath=${pkgs.janet}/lib --ldflags=-L${pkgs.glibc}/lib '
  '';
in {
  options.languages.janet = {
    enable =
      mkEnableOption "Enables support for the Janet programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    environment.variables = {
      # needs mkdir -p ~/.local/share/janet or maybe hm to install with jpm deps
      JANET_PATH = "${janetTreeDir}/lib";
      JANET_TREE = janetTreeDir; # ~/.local/share/janet/jpm_tree/
    };

    users.users.${user} = {
      packages = with pkgs; [
        janet

        jpm
        gcc # required for jpm build which uses cc
      ];
    };
  };
}
