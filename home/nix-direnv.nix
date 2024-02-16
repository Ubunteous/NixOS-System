{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.nix-direnv;
  homecfg = config.home;
in
{
  options.home.nix-direnv = {
    enable = mkEnableOption "Enable support for nix-direnv";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    # Instructions:
    # + add the following shell.nix
    # + run the echo ... and direnv commands

    # { pkgs ? import <nixpkgs> {}}:
    # pkgs.mkShell { packages = [ pkgs.hello ]; }

    # $ echo "use nix" >> .envrc # for shell.nix
    # $ echo "use nix foo.nix" >> .envrc # for foo.nix
    # $ direnv allow

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
      # enableFishIntegration = true; # true by default
    };
  };
}
