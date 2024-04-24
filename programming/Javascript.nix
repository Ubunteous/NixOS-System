{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.javascript;
  langcfg = config.languages;
in {
  options.languages.javascript = {
    enable =
      mkEnableOption "Enables support for the Javascript programming language";

    addTypescript = mkOption {
      type = types.bool;
      default = false;
      description =
        lib.mdDoc "Enables support for the Typescript programming language";
    };
  };

  config = mkMerge [
    (mkIf (langcfg.enable && cfg.enable) {
      users.users.${user} = {
        packages = with pkgs; [
          # yarn2nix

          # biome # lint/format => does not send to stdout
          nodePackages.typescript-language-server
          nodePackages.prettier
          nodePackages.eslint

          # jupyter. setup with ijsinstall command
          nodePackages.ijavascript

          nodejs
          create-react-app
        ];
      };
    })
    (mkIf (langcfg.enable && cfg.addTypescript) {
      users.users.${user} = {
        packages = with pkgs; [ typescript nodePackages.ts-node ];
      };
    })
  ];
}
