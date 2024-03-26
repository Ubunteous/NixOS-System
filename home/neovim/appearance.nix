{ config, lib, pkgs, ... }:

with lib;
let cfg = config.home.neovim;
in {
  options.home.neovim.appearance = {
    enable = mkEnableOption "Configure appearance plugins for vim";
  };

  config = mkIf (cfg.distro == "nix" && cfg.appearance.enable) {
    programs.neovim.plugins = with pkgs.vimPlugins; [

      ##############
      # APPEARANCE #
      ##############

      {
        plugin = alpha-nvim;
        type = "lua";
        config = ''
          local alpha = require("alpha")
          local dashboard = require("alpha.themes.dashboard")

          -- Set header
          dashboard.section.header.val = {
            "           ▄ ▄                   ",
            "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
            "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
            "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
            "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
            "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
            "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
            "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
            "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
                            }

          -- Set menu
          dashboard.section.buttons.val = {
            -- dashboard.button("enter", "󰈚  Restore Session", ":SessionRestore<cr>"),
            dashboard.button("enter", "󰈚  Open Terminal", ":terminal<cr>"),
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
            dashboard.button("r", "󰈚  Recent Files", ":Telescope oldfiles<CR>"),
            dashboard.button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
            dashboard.button("q", "󰗼  Quit NVIM", ":qa<CR>"),
                                         }

          local fortune = require("alpha.fortune")
          dashboard.section.footer.val = fortune()
          dashboard.section.footer.opts.hl = '@alpha.footer'
          table.insert(dashboard.config.layout, 5, {
            type = 'padding',
            val = 1,
          })
          -- Send config to alpha
          -- alpha.setup(dashboard.opts)

          -- Disable folding on alpha buffer
          vim.cmd([[
              autocmd FileType alpha setlocal nofoldenable
          ]])
          require("alpha").setup(dashboard.opts)
        '';
      }

      {
        plugin = oil-nvim; # file explorer
        type = "lua";

        config = ''
          -- default_file_explorer = true,

          require("oil").setup({
            columns = {
              "icon",
              "permissions",
            },
          })

          wk.register({
            ["<leader>u"] = {
                name = "utilities",
                o = { "<cmd>Oil<cr>", "Oil" },
            },
          })
        '';
      }

      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require("lualine").setup({
                options = { theme = "gruvbox" },

                -- sections = {
                -- 	 lualine_a = {'buffers'},
                -- 	 lualine_b = {'hostname'},
                -- 	 lualine_c = {'location'},

                -- 	 lualine_x = {'tabs'},
                -- 	 lualine_y = {'windows'},
                -- 	 lualine_z = {'filetype'},
                -- },
          })
        '';
      }

      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = ''
          require('nvim-web-devicons').setup()
        '';
      }

      {
        plugin = monokai-pro-nvim;
        type = "lua";
        config = ''
          -- classic | octagon | pro | machine | ristretto | spectrum
          require('monokai-pro').setup()
          vim.cmd([[colorscheme monokai-pro-classic]])
        '';
      }

      # requires nvim-web-devicons
      {
        plugin = barbar-nvim;
        type = "lua";
        config = ''
          require'barbar'.setup {
              -- auto_hide = 1,
              -- clickable = false,
              -- minimum_padding = 0,
              maximum_padding = 0,
          }

          -- offset required if using a tree
          -- require'barbar.api'.set_offset(20)
        '';
      }

      ########################
      # GARBAGE - APPEARANCE #
      ########################

      # {
      #   plugin = nerdtree;
      #   config = ''
      #     autocmd VimEnter * NERDTree | wincmd p
      #     let g:NERDTreeWinSize=20
      #     let NERDTreeMinimalUI=1

      #     let g:NERDTreeDirArrowExpandable = ""
      #     let g:NERDTreeDirArrowCollapsible = ""

      #     " close nerdtree alongside file
      #     autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") 
      #     \ && b:NERDTree.isTabTree()) | q | endif
      #   '';
      # }

      # icon colour requires set termguicolors in .vimrc
      # {
      #   plugin = chadtree;
      #   config = ''
      #     autocmd VimEnter * CHADopen --nofocus --version-ctl
      #     let g:chadtree_settings = { 'view.width': 25, "theme.text_colour_set": "nord" }
      #   '';
      # }

      # vim-airline # alternative: lualine, lightline, vim-powerline
      # {
      #   plugin = vim-airline-themes;
      #   config = "let g:airline_theme='molokai'";
      # }

      # vim-startify # old startup screen

      # this plugin is good too but I will stick to alpha
      # {
      #   plugin = dashboard-nvim;
      #   type = "lua";

      #   config = ''
      #     local db = require("dashboard")

      #     db.setup({
      #       theme = 'hyper',
      #       config = {
      #         week_header = {
      #          enable = true,
      #         },
      #         shortcut = {
      #           { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
      #           {
      #             icon = ' ',
      #             icon_hl = '@variable',
      #             desc = 'Files',
      #             group = 'Label',
      #             action = 'Telescope find_files',
      #             key = 'f',
      #           },
      #           {
      #             desc = ' Apps',
      #             group = 'DiagnosticHint',
      #             action = 'Telescope app',
      #             key = 'a',
      #           },
      #           {
      #             desc = ' dotfiles',
      #             group = 'Number',
      #             action = 'Telescope dotfiles',
      #             key = 'd',
      #           },
      #         },
      #       },
      #     })
      #   '';
      # }

      # {
      #   plugin = neo-tree-nvim;
      #   type = "lua";
      #   config = ''
      #     require("neo-tree").setup({
      #       close_if_last_window = true,

      #       indent = {
      #         indent_size = 2,
      #         padding = 0,
      #       },

      #       window = {
      #         width = 20,
      #       },

      #       buffers = {
      #         follow_current_file = {
      #           enabled = true,
      #         }
      #       },

      #       filesystem = {
      #         filtered_items = {
      #           visible = true,
      #         },
      #       },
      #     })

      #     -- vim.cmd[[
      #     --   augroup NEOTREE_AUGROUP
      #     --     autocmd!
      #     --     au VimEnter * lua vim.defer_fn(function() vim.cmd("Neotree show left") end, 10)
      #     --   augroup END
      #     -- ]]

      #     -- THIS BREAKS MY PYTHON CONFIG AND MORE
      #     -- auto start
      #     -- vim.api.nvim_create_augroup("neotree_autoopen", { clear = true })
      #     -- vim.api.nvim_create_autocmd("BufRead", { -- Changed from BufReadPre
      #     --   desc = "Open neo-tree on enter",
      #     --   group = "neotree_autoopen",
      #     --   once = true,
      #     --   callback = function()
      #     --     if not vim.g.neotree_opened then
      #     --       vim.cmd "Neotree show"
      #     --       vim.g.neotree_opened = true
      #     --     end
      #     --   end,
      #     -- })
      #   '';
      # }

      # vim-vinegar # like oil. press - to see current dir

      # lightline-vim # lualine is more configurable
      # vim-powerline # not in nixpkgs and deprecated

      # fern-vim # tree
      # nvimtree # not in nixpkgs

      # dressing-nvim # ok but need config and useful sporadically

      # good but new monokai-pro in lua
      # {
      #   plugin = molokai;
      #   config = ''
      #       let g:molokai_original = 1
      #       colorscheme molokai
      #     '';
      # }

      # {
      #   plugin = tokyonight-nvim;
      #   type = "lua";
      #   config = ''
      #     require("tokyonight").setup({
      #       style = "moon", -- storm, moon, night, day
      #     })
      #   '';
      # }

      # {
      #   plugin = catppuccin-nvim;
      #   type = "lua";
      #   config = ''
      #         require("catppuccin").setup({
      #           flavour = "mocha", -- latte, frappe, macchiato, mocha
      #         })
      #       '';
      # }

      # {
      #   plugin = kanagawa-nvim;
      #   type = "lua";
      #   config = ''
      #     require('kanagawa').setup({
      #       theme = "wave" -- wave, lotus, dragon
      #     })
      #   '';
      # }

      # use nvim devicons instead
      # vim-devicons # nerdtree icons
    ];
  };
}
