{ config, lib, pkgs, home-manager, user, ... }:

with lib;
let
  cfg = config.home.neovim;
  homecfg = config.home;
in
{
  options.home.neovim.enable = mkEnableOption "Neovim configuration";

  imports = [
    ./appearance.nix
    ./languages.nix

    ./search.nix
    ./utilities.nix
    ./passive.nix

    ./git.nix
    ./lsp.nix

    ./misc.nix # completion, format, snippets and more
  ];

  config = mkIf (homecfg.enable && cfg.enable) {
    home-manager.users.${user} = {
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

        plugins = with pkgs.vimPlugins;         
          [
            #############
            # WHICH-KEY #
            #############

            {
              plugin = which-key-nvim;
              type = "lua";
              # extra lines are normal
              config = ''


                local wk = require("which-key")

                wk.setup({
                   -- window = { border = "single", },
                   layout = {
                      align = "center", -- align columns left, center or right
                      height = { min = 4, max = 30 }, -- min and max height of the columns
                      width = { min = 20, max = 45 }, -- min and max width of the columns
                      spacing = 3, -- spacing between columns  
                   },
                })

                -- use this hack to remove the ugly default black background
                vim.api.nvim_set_hl(0, "WhichKeyFloat", { fg = "Red" })
                
                wk.register({
                  ["<leader>w"] = {
                      name = "window",
                      a = { "<cmd>ChooseWin<cr>", "Choose Window" },
                
                      m = { "<C-W>h", "Window left" },
                      n = { "<C-W>j", "Window down" },
                      e = { "<C-W>k", "Windiw up" },
                      i = { "<C-W>l", "Window right" },
                  },
                  ["<leader>"] = {
                     s = { "<cmd>w<cr>", "Save" },
                     q = { "<cmd>q<cr>", "Quit" },
                  },
                })
              '';
            }
          ];
      };
    };
  };
}  
