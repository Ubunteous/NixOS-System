{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.rust;
  langcfg = config.languages;
in {
  options.languages.rust = {
    enable = mkEnableOption "Enables support for the rust programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        rustc
        rust-script # used by ob-rust. modify it to accept rustc

        # rustup # toolchain installer

        cargo # packet manager
        clippy # lint
        rustfmt # format
        rust-analyzer # lsp
      ];
    };
  };
}
