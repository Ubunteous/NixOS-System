{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.nix;
  langcfg = config.languages;
  in {
    options.languages.nix = {
    enable = mkEnableOption "Enables support for the nix programming language";
    };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        nil # lsp
        # nixd # lsp. less mature than nil

        nixfmt # formatter
        # alejandra # formatter

        deadnix # find unused vars/params
        nixpkgs-hammering # check errors in packages

        statix # linter
        # Ignore lints and fixes by creating a statix.toml file at your project root:
        # use statix list for more options
        # disabled = ["repeated_keys"]
        # nix_version = '2.4'
        # ignore = ['.direnv', "packages/nodePackages/node-env.nix", "npins/default.nix"]
      ];
    };
  };
}
