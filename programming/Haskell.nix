{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.haskell;
  langcfg = config.languages;
in {
  options.languages.haskell = {
    enable =
      mkEnableOption "Enables support for the Haskell programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        ghc

        # can fail with incorrect hs code (and different dependencies - ghc)
        # seems to run once and end successfully which stops eglot
        haskell-language-server

        hlint
        ormolu
        # stylish-haskell
        # haskellPackages.intero # repl
        # haskellPackages.fourmolu # configurable branch of ormolu

        # haskellPackages.kmonad # currently broken in 22.11
        # cabal-install # packet manager + build
        # stack # ghc + package manager + build/test/benchmark
      ];
    };
  };
}
