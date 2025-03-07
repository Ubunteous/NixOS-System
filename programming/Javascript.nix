{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.javascript;
  langcfg = config.languages;

  nodepkgs = with pkgs.nodePackages;
    [
      typescript-language-server
      prettier
      eslint

      # jupyter. setup with ijsinstall command
      # ijavascript # 1/2025. broken

      # jshint

      # "@jest" # unit tests
      # mocha # unit testing framework
    ] ++ [ pkgs.stable.nodePackages.ijavascript ];
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

            # runtime (bun is the fastest)
            # nodejs
            bun # also a bundler, transpiler and package manager
            # deno

            # package managers:
            # node2nix
            # yarn2nix
            # yarn-berry # next-gen yarn
            # pnpm # link deps to avoid dupplicates

            # create-react-app

            # biome # lint/format => does not send to stdout. try later
            # stylelint # css linter
            # validator-nu # html/css checker
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
