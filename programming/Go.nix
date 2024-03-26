{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.go;
  langcfg = config.languages;
in {
  options.languages.go = {
    enable = mkEnableOption "Enables support for the Go programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        go # bundled with gofmt formatter
        gopls # lsp

        go-tools # linter
        # golangci-lint # run linters in parallel
      ];
    };
  };
}
