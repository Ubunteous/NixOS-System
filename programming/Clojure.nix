{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.clojure;
  langcfg = config.languages;
in {
  options.languages.clojure = {
    enable =
      mkEnableOption "Enables support for the Clojure programming languages";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        clojure

        clojure-lsp
        cljfmt
        clj-kondo # => linter (included in clojure-lsp)
        # joker # interpreter, linter and formatter

        # build automation and dependency management
        # leiningen

        # scripting
        # babashka
      ];
    };
  };
}
