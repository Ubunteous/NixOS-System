{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.neovim;
  homecfg = config.home;
in
{
  options.home.neovim.enable = mkEnableOption "Neovim configuration";

  # import ordered reversed as which-key needs to be at config top
  imports = [
    ./misc.nix # completion, format, snippets and more
    ./lsp.nix
    ./git.nix

    ./passive.nix
    ./utilities.nix
    ./search.nix

    ./languages.nix
    ./appearance.nix
    ./which-key.nix
  ];

  config = mkIf (homecfg.enable && cfg.enable) {
    ##############
    #   NEOVIM   #
    ##############

    # For help, use helptags (:help tag/telescope) or :h index
    
    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;

      # extraLuaConfig = '' '';
      
      # extraConfig = lib.fileContents ../path/to/your/init.vim;
      extraConfig = lib.fileContents ./vimrc;
    };
  };
}  
