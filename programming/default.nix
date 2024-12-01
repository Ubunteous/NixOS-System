{ config, lib, ... }:

with lib; {
  options.languages.enable = mkEnableOption "Programming Languages";

  imports = [
    ./Python.nix
    ./Godot.nix
    ./Csharp.nix

    ./C.nix
    ./Nix.nix
    ./Lua.nix
    ./Haskell.nix

    ./Java.nix
    ./Javascript.nix

    ./Shell.nix
    # ./Typst.nix
    ./LaTeX.nix
    ./PostgreSQL.nix

    ./Go.nix
    ./Rust.nix

    ./Guile.nix
    ./Janet.nix
    ./Clojure.nix
    ./Common-Lisp.nix
    ./Elixir.nix
  ];

  # options.languages = {
  #   enable = mkEnableOption "Enables support for programming languages";
  # };

  # config = mkIf cfg.enable {};
}
