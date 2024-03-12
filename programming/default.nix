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

    ./Shell.nix
    ./Java.nix
    ./Javascript.nix
    ./PostgreSQL.nix

    ./Rust.nix
    ./Clojure.nix
  ];

  # options.languages = {
  #   enable = mkEnableOption "Enables support for programming languages";
  # };

  # config = mkIf cfg.enable {};
}
