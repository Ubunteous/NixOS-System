{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.elixir;
  langcfg = config.languages;
  in {
    options.languages.elixir = {
      enable =
	mkEnableOption "Enables support for the Elixir programming language";
    };

    config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        elixir # comes with mix which can install credo
        elixir-ls
      ];
    };
  };
}
