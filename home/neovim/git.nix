{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.neovim.git;
  homecfg = config.home;
in
{
  options.home.neovim.git = {
    enable = mkEnableOption "Configure git plugins for vim";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        #######
        # GIT #
        #######
        
        vim-fugitive
        gv-vim # adds GV commit browser to fugitive

        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = ''
            require('gitsigns').setup()
          '';
        }

        {
          plugin = diffview-nvim;
          type = "lua";
          config = ''
            require('diffview').setup()
          '';
        }

        ####################
        # OTHER INTERFACES #
        ####################

        # lazygit-nvim
        
        # vimagit # magit
        
        # like magit
        # requires setup as shown on git page (not tested)
        # {
        #   plugin = neogit;
        #   config = ''
        #     # "NeogitOrg/neogit",
        #     # dependencies = {
        #     #   "nvim-lua/plenary.nvim", -- required
        #     #   "sindrets/diffview.nvim", -- optional - Diff integration
        
        #     #   -- Only one of these is needed, not both.
        #     #   "nvim-telescope/telescope.nvim", -- optional
        #     #   "ibhagwan/fzf-lua", -- optional
        #     # },
        #     # config = true
        #   '';
        # }

        #################
        # GARBAGE - GIT #
        #################

        # use gitsigns-nvim instead
        # # diff in gutter
        # {
        #   plugin = vim-gitgutter;
        #   config = ''
        #     highlight GitGutterAdd    guifg=#009900 ctermfg=2
        #     highlight GitGutterChange guifg=#bbbb00 ctermfg=3
        #     highlight GitGutterDelete guifg=#ff2222 ctermfg=1

        #     " fix gutter/SignColumn appearance (colour)
        #     set termguicolors 
        #   '';
        # }        

        # nerdtree-git-plugin # git status # archived
      ];
    };
}
