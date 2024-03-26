{ config, lib, pkgs, ... }:

with lib;
let cfg = config.home.neovim;
in {
  options.home.neovim.utilities = {
    enable = mkEnableOption "Configure utilities for vim";
  };

  config = mkIf (cfg.distro == "nix" && cfg.utilities.enable) {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      #############
      # UTILITIES #
      #############

      undotree # worth configuring more

      nerdcommenter # works well

      # much more configurable than vim-commentary. needs lua setup
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
          -- comment-nvim
          require('Comment').setup()
        '';
      }

      vim-visual-multi # great

      # like ace-window        
      {
        plugin = vim-choosewin;
        type = "lua";
        config = ''
          -- if you want to use overlay feature
          vim.g.choosewin_overlay_enable = 1
        '';
      }

      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup({
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
              enable = true,
              update_root = true
            },
          })
        '';
      }

      # requires nvim-tree-lua
      {
        plugin = project-nvim;
        type = "lua";
        config = ''
          require("project_nvim").setup()
          require('telescope').load_extension('projects')
        '';
      }

      {
        plugin = harpoon;
        type = "lua";
        config = ''
          require("harpoon").setup()
          require("telescope").load_extension('harpoon')

          wk.register({
            ["<leader>g"] = {
                name = "harpoon",
                f = { function() require("harpoon.mark").add_file() end, "Harpoon Add File" },
                u = { function() require("harpoon.ui").toggle_quick_menu() end, "Harpoon Visit File" },
            },
          })
        '';
      }

      #######################
      # GARBAGE - UTILITIES #
      #######################

      # vim-dirvish # dir viewer. no color yet but works well

      # vim-nerdtree-tabs # unmaintained
      # vim-commentary # adds gc command (gcc for current line)
      # tcomment_vim # inferior to other options

      # {
      #   plugin = vim-which-key;
      #   config = ''
      #     " set timeout for which-key
      #     set timeoutlen=500 " 1000ms by default

      #     let g:mapleader = "\<Space>"
      #     let g:maplocalleader = ','
      #     nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
      #     nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
      #   '';
      # }

      # vim-signature # place (book)marks and move to them # does not seem to work
      # vim-colorschemes # useless and maybe already built-in
      # vim-move # move lines up/down # does not seem to work
      # vim-expand-region # could not find command. does it work?
      # vim-ctrlspace # manage tabs, sessions, bookmarks => not in nixpkgs        
      # vim-multiple-cursors # deprecated for vim-visual-multi

      # nvim-spectre # replace text. undo not supported. not sure how to use and dislike it

      # clever-f-vim # repeats f command with f key like flash
      # vim-bbye # like bufdelete but unmaintained
      # vim-sandwich # like surround. does not play well with s

      # # repl
      # {
      #   plugin = iron-nvim;
      #   type = "lua";
      #   config = ''
      #   local iron = require("iron.core")

      #   iron.setup({
      #     config = {
      #       -- Whether a repl should be discarded or not
      #       scratch_repl = true,
      #       -- Your repl definitions come here

      #       repl_definition = {
      #         python = {
      #           -- Can be a table or a function that
      #           -- returns a table (see below)
      #           command = { "python" },
      #         },
      #       },

      #       -- How the repl window will be displayed
      #       -- See below for more information
      #       repl_open_cmd = require("iron.view").right(30),
      #     },

      #     -- Iron doesn't set keymaps by default anymore.
      #     -- You can set them here or manually add keymaps to the functions in iron.core
      #     keymaps = {
      #       send_motion = "<leader>ic",
      #       visual_send = "<leader>ic",
      #       send_file = "<leader>if",
      #       send_line = "<leader>il",
      #       send_mark = "<leader>im",
      #       mark_motion = "<leader>imc",
      #       mark_visual = "<leader>imc",
      #       remove_mark = "<leader>imd",
      #       cr = "<leader>i<cr>",
      #       interrupt = "<leader>i<space>",
      #       exit = "<leader>iq",
      #       clear = "<leader>ix",
      #                                                                          },

      #     -- If the highlight is on, you can change how it looks
      #     -- For the available options, check nvim_set_hl
      #     highlight = { italic = true, },
      #     ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      #   })

      #   -- iron also has a list of commands, see :h iron-commands for all available commands
      #   vim.keymap.set("n", "<leader>is", "<cmd>IronRepl<cr>")
      #   vim.keymap.set("n", "<leader>ir", "<cmd>IronRestart<cr>")
      #   vim.keymap.set("n", "<leader>iF", "<cmd>IronFocus<cr>")
      #   vim.keymap.set("n", "<leader>ih", "<cmd>IronHide<cr>")
      # '';
      # }

      # plenary-nvim # neovim lua library
      # taglist # source code browser. last update 14y

      # # useless representation
      # {
      #   plugin = telescope-undo-nvim;
      #   type = "lua";
      #   config = ''
      #     -- extension config goes in telescope setup block
      #     -- require("telescope").setup({ extensions = { undo = {}, }, })
      #     require("telescope").load_extension("undo")
      #   '';
      # }

      # needs vim to be compiled with python. last updated 3y
      # gundo-vim
    ];
  };
}
