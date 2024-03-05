{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.neovim.misc;
  homecfg = config.home;
in
{
  options.home.neovim.misc = {
    enable = mkEnableOption "Configure misc plugins for vim";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      ##############
      # COMPLETION #
      ##############

      # will need more time to compare these tools
      supertab # tab completion

      {
        plugin = deoplete-nvim; # extra langs on nixpkg
        config = ''
            let g:deoplete#enable_at_startup = 1
          '';
      }
      
      ############
      # SNIPPETS #
      ############
      
      {
        plugin = luasnip;
        type = "lua";
        config = ''
            local ls = require("luasnip")

            -- for "all" filetypes create snippet for "def"
            ls.add_snippets("all", { -- "all"
              ls.parser.parse_snippet(
                'def',
                'def ''${1}(''${2})\n{\n\t''${3}\n}'),
                                   })
          
            -- Map "Ctrl + p" (in insert mode)
            -- to expand snippet and jump through fields.
            vim.keymap.set(
            'i',
            '<c-p>',
            function()
              if ls.expand_or_jumpable() then
                ls.expand_or_jump()
              end
            end
            )
          '';
      }
      
      {
        plugin = friendly-snippets;
        type = "lua";
        config = ''
            require("luasnip.loaders.from_vscode").lazy_load()
          '';
      }
      
      cmp_luasnip
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
              local cmp = require('cmp')
        
               cmp.setup({
                 snippet = {
                   expand = function(args)
                     require('luasnip').lsp_expand(args.body)
                   end,
                 },

              -- window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
              -- },
                mapping = cmp.mapping.preset.insert({
                  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                  { name = 'luasnip' }, -- For luasnip users.
                })
               })
            '';
      }
      
      ##########
      # FORMAT #
      ##########

      {
        plugin = conform-nvim;
        type = "lua";
        config = ''
            require("conform").setup({
              formatters_by_ft = {
                -- lua = { "stylua" },
                python = { "black" },
              },

              format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_fallback = true,
              },
              
              -- If this is set, Conform will run the formatter asynchronously after save.
              -- It will pass the table to conform.format().
              -- This can also be a function that returns the table.
              format_after_save = {
                lsp_fallback = true,
                                 },
            })
          '';
      }
      
      #########
      # TESTS #
      #########

      {
        # uses plenary and neodev
        plugin = neotest;
        type = "lua";
        config = ''
            require("neotest").setup({
              adapters = {
                require("neotest-python")({
                  dap = { justMyCode = false },
                }),
              },
            })
          '';
      }
      neotest-python
      
      # for async commands (like starting a repl)
      vim-dispatch

      #########
      # LATER #
      #########

      # check package managers (lazy) and package lazy eval
      # mini-nvim # 35+ scripts
      # vim-startuptime

      # GIT #
      # git-blame-nvim
      # git-conflict-nvim
      # vim-signify # diff in gutter. maybe like nvim
      # git-messenger-vim # commit message under cursor

      # PASSIVE #
      # targets-vim # more textojects. try later

      # SEARCH #
      # fzf-vim # very powerful
      # ctrlp-vim
      # unite-vim # development stopped
      # LeaderF # comes with its own interface
      # vim-clap # versatile thanks to various providers

      # UTILITIES #
      # vim-repeat # add repeat support (with .) to surround and unimpaired        
      # vimproc-vim # interactive command execution
      # asyncrun-vim # async commands. see their output with :copen
      # splitjoin-vim # split one liner into multi lines with gS/gJ
      # vim-easy-align # works. use later
      # toggleterm-nvim # invoke term in vim

      # LANGUAGES #
      # vim-python-pep8-indent # already in python-mode
      # python-syntax # already in python-mode
      # jedi-vim # python autocompletion
      # lint: find a plugin for black
      # vim-js-beautify # requires a pip/npm package
      # vim-orgmode # needs speed-dating?
      # neorg # new org (norg) format
      # misc
      # vim-json
      # vim-just
      # haskell-vim
      # vim-dadbod # for db
      # vim-dadbod-ui
      # vim-dadbod-completion
      # vim-markdown
      # vim-instant-markdown # requires pip/npm dependency
      # html5-vim
      # scss-syntax-vim
      # vim-javascript
      # orgmode
      
      # MISC #
      # hydra-nvim
      # distant-nvim # remote editing
      # nvim-bqf # quick fix improvement
      # sniprun # eval selection (repl like)
      # bufdelete-nvim # preserve buffer layout on closure

      ########################
      # GARBAGE - COMPLETION #
      ########################

      # neocomplcache # not in nixpkgs
      # neocomplete-vim # deprecated?
      # YouCompleteMe # works well but heavy (1gb?)
      # ncm2 # no updates

      ######################
      # GARBAGE - SNIPPETS #
      ######################
      
      # # made in vimscript
      # vim-snipmate
      # utilsnips
      # vim-snippets

      # emmet-vim # expand abbrev. last update 3y

      ####################
      # GARBAGE - FORMAT #
      ####################

      # formatter-nvim

      # # made in vimspcript
      # neoformat
      # vim-autoformat
      # vim-codefmt

      ##################
      # GARBAGE - TMUX #
      ##################

      # not necessary right now as I use wezterm
      
      # vim-tmux-navigator
      # vimux # tmux interaction
      # tmuxline-vim # tmux status line
      # smart-splits-nvim

      ###################
      # GARBAGE - TESTS #
      ###################
      
      # those two are in vimscript
      # neomake
      ];
  };
}
