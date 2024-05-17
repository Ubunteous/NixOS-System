{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.javascript;
  langcfg = config.languages;

  nodepkgs = with pkgs.nodePackages; [
    typescript-language-server
    prettier
    eslint

    # jupyter. setup with ijsinstall command
    ijavascript

    # "@jest" # unit tests
    # mocha # unit testing framework
  ];
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
        packages = with pkgs;
          [
            nodejs

            # node2nix
            # yarn2nix
            # create-react-app
            # biome # lint/format => does not send to stdout
          ] ++ nodepkgs;
      };
    })
    (mkIf (langcfg.enable && cfg.addTypescript) {
      users.users.${user} = {
        packages = with pkgs; [ typescript nodePackages.ts-node ];
      };
    })
  ];
}
