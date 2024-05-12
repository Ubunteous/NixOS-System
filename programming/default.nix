{ config, lib, ... }:

with lib;
{
  options.languages.enable = mkEnableOption "Programming Languages";
    
  imports = [
    ./Python.nix
    ./LaTeX.nix
    ./Godot.nix

    ./C.nix
    ./Nix.nix
    ./Lua.nix
    ./Haskell.nix

    ./Java.nix
    ./Javascript.nix

    ./Shell.nix
    ./LaTeX.nix
    ./PostgreSQL.nix

    ./Go.nix
    ./Rust.nix

    ./Guile.nix
    ./Clojure.nix
    ./Common-Lisp.nix
    ./Elixir.nix
  ];

  # options.languages = {
  #   enable = mkEnableOption "Enables support for programming languages";
  # };

  # config = mkIf cfg.enable {};
}
