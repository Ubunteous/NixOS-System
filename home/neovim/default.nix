{ config, lib, ... }:

with lib;
let
  homecfg = config.home;
  nvimcfg = config.home.neovim;
  in {
    options = {
      home.neovim = {
	enable = mkEnableOption "Neovim configuration";

	distro = mkOption {
        default = "nix";
        type = types.enum [ "nix" "Lazy" "lazy" ];
        description = lib.mdDoc ''
          Choose the neovim configuration to use
        '';
      };
    };
  };

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

    ./Lazy.nix
    ./lazy.nix
  ];

  config = mkIf (homecfg.enable && nvimcfg.enable) {
    ##############
    #   NEOVIM   #
    ##############

    # For help, use helptags (:help tag/telescope) or :h index

    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;

      extraLuaConfig = lib.fileContents ./Lua/settings.lua;
      # extraConfig = lib.fileContents ./vimrc;
    };
  };
}
