{ config, pkgs, user, ... }:

{
  users.users.${user} = {
    packages = with pkgs; [
      clojure

      # linter and lsp
      # clj-kondo # => included in clojure-lsp
      clojure-lsp
      
      # build automation and dependency management
      # leiningen

      # scripting
      # babashka
    ];
  };
}
