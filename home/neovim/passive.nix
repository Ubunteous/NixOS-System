{ config, lib, pkgs, ... }:

with lib;
let cfg = config.home.neovim;
in {
  options.home.neovim.passive = {
    enable = mkEnableOption "Configure passive plugins for vim";
  };

  config = mkIf (cfg.distro == "nix" && cfg.passive.enable) {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      ###########
      # PASSIVE #
      ###########

      {
        plugin = rainbow-delimiters-nvim;
        type = "lua";
        config = ''
          -- This module contains a number of default definitions
          local rainbow_delimiters = require 'rainbow-delimiters'

          ---@type rainbow_delimiters.config
          -- vim.g.rainbow_delimiters = {

          require('rainbow-delimiters.setup').setup {
            strategy = {
              ['''] = rainbow_delimiters.strategy['global'],
              vim = rainbow_delimiters.strategy['local'],
            },
            query = {
              ['''] = 'rainbow-delimiters',
              lua = 'rainbow-blocks',
            },
            priority = {
              ['''] = 110,
              lua = 210,
            },
            highlight = {
              'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
          }
        '';
      }

      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          local highlight = {
              "RainbowRed",
              "RainbowYellow",
              "RainbowBlue",
              "RainbowOrange",
              "RainbowGreen",
              "RainbowViolet",
              "RainbowCyan",
          }
          local hooks = require "ibl.hooks"
          -- create the highlight groups in the highlight setup hook, so they are reset
          -- every time the colorscheme changes
          hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
              vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
              vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
              vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
              vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
              vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
              vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
              vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
          end)

          vim.g.rainbow_delimiters = { highlight = highlight }
          require("ibl").setup {
            scope = { highlight = highlight },
            indent = { highlight = highlight },
          }

          hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        '';
      }

      vim-eunuch # sh commands as syntactic sugar

      # use limelight and goyo together
      # autocmd! User GoyoEnter Limelight
      # autocmd! User GoyoLeave Limelight!
      limelight-vim # highlight current block. good addition to goyo
      goyo-vim # distraction free like olivetti

      vim-surround # quick pairs operation
      vim-unimpaired # adds new bindings for common command

      {
        plugin = nvim-autopairs; # more configurable
        type = "lua";
        config = ''
          require("nvim-autopairs").setup({
            enable_check_bracket_line = false

            -- don't add pair if next character is alpha or .
            -- ignored_next_char = "[%w%.]"
          })            
        '';
      }

      # popup suggestion in : menu
      {
        plugin = wilder-nvim;
        type = "lua";
        config = ''
          local wilder = require('wilder')
          wilder.setup({
            modes = {':', '/', '?'},
            next_key = '<Down>',
            -- previous_key = '<S-Tab>',
            accept_key = '<Tab>',
            -- reject_key = '<Up>',
            -- enable_cmdline_enter = 0,
          })

          -- setup is experimental in lua unlike the following .vimrc line
          -- if use vim-plug, place this after call plug#end()
          -- call wilder#setup({'modes': [':', '/', '?']})

          -- wilder renderer
          wilder.set_option('renderer', wilder.popupmenu_renderer({
          -- highlighter applies highlighting to the candidates
            highlighter = wilder.basic_highlighter(),
          }))

          wilder.set_option('renderer', wilder.popupmenu_renderer({
             highlighter = wilder.basic_highlighter(),
             left = {' ', wilder.popupmenu_devicons()},
             right = {' ', wilder.popupmenu_scrollbar()},
          }))
        '';
      }

      {
        plugin = nvim-treesitter;
        type = "lua";
        config = ''
          require'nvim-treesitter.configs'.setup {
            -- If you need to change the installation directory of the parsers (see -> Advanced Setup)
            -- parser_install_dir = "/some/path/to/store/parsers",
            -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

            highlight = {
              enable = true,
            },

            indent = {
              enable = true
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                  init_selection = "gnn", -- set to `false` to disable one of the mappings
                  node_incremental = "grn",
                  scope_incremental = "grc",
                  node_decremental = "grm",
                },
            },
          }
        '';
      }
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.lua
    ];

    #####################
    # GARBAGE - PASSIVE #
    #####################

    # vim-indent-guides
    # indentLine # archived and not pretty
    # vim-sleuth # filename based auto-indent?

    # rainbow_parentheses # good but not updated in a decade
    # syntastic # syntax check => deprecated for ale
    # rainbow # more options. needs: let g:rainbow_active = 1

    # tabular # align with a filter. broken. not updated in five years
    # minibufferexpl # not in nixpkgs
    # auto-session # config how restore session. maybe useless

    # legendary-nvim # like which-key

    # delimitMate # simple and sweet for pairs. avoids single " pitfall
    # auto-pairs # good but has issue with single "

    # replaced by vim settings
    # {
    #   plugin = vim-better-whitespace;
    #   config = ''
    #     let g:better_whitespace_enabled=1
    #     " let g:strip_whitespace_on_save=1 " try later

    #     " use this if dashboard or other needs it disabled
    #     " let g:better_whitespace_filetypes_blacklist=
    #     " \ ["dashboard", "diff", "git", "gitcommit", "unite", "qf", "help", "markdown", "fugitive"]
    #   '';
    # }

    # # lisp repl. bring back if I stop using emacs for clj
    # {
    #   plugin = conjure;
    #   type = "lua";
    #   config = ''
    #     -- Disable the documentation mapping
    #     vim.g["conjure#mapping#doc_word"] = false

    #     -- Rebind it from K to <prefix>gk
    #     vim.g["conjure#mapping#doc_word"] = "gk"

    #     -- Reset it to the default unprefixed K (note the special table wrapped syntax)
    #     -- vim.g["conjure#mapping#doc_word"] = {"K"}
    #   '';
    # }

  };
}
