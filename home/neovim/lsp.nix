{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.neovim.lsp;
  homecfg = config.home;
in
{
  options.home.neovim.lsp = {
    enable = mkEnableOption "Configure lsp plugins for vim";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      #######
      # LSP #
      #######
      
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
            local lspconfig = require('lspconfig')
            lspconfig.pyright.setup{}
            -- lspconfig.pylsp.setup{}

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
        
            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
              group = vim.api.nvim_create_augroup('UserLspConfig', {}),
              callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>wl', function()
                  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<space>f', function()
                  vim.lsp.buf.format { async = true }
                end, opts)
              end,
            })
          '';
      }
      
      # improve lsp experience
      {
        plugin = lspsaga-nvim;
        type = "lua";
        config = ''
            require('lspsaga').setup({})
        '';
      }

      #############
      # DEBUGGERS #
      #############

      nvim-dap

      # uses neodev
      {
        plugin = nvim-dap-ui;
        type = "lua";

        config = ''
            require("dapui").setup()
            
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.before.attach.dapui_config = function()
              dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
              dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
              dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
              dapui.close()
            end
          '';
      }
      
      {
        plugin = neodev-nvim; # lua/nvim
        type = "lua";
        config = ''
            require("neodev").setup({
              library = { plugins = { "nvim-dap-ui", "neotest" }, types = true },

              override = function(root_dir, library)
                if root_dir:find("/etc/nixos", 1, true) == 1 then
                  library.enabled = true
                  library.plugins = true
                end
              end,
            })
          '';
      }

      # {
      #   plugin = nvim-dap-python;
      #   type = "lua";
      #   config = ''
      #     -- require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
      #     require('dap-python').setup()
      #     -- require('dap-python').test_runner = 'pytest'
      #   '';
      # }

      {
        plugin = trouble-nvim;
        type = "lua";
        config = ''
            require("trouble").setup({
                position = "right", -- bottom, top, left, right
                width = 35, -- relevant when position is left or right
                -- height = 25, -- relevant when position is top or bottom
                -- mode = "workspace_diagnostics", -- or document_diagnostics, quickfix, lsp_references, loclist
                -- auto_fold = true,
            })
          '';
      }
      #################
      # GARBAGE - LSP #
      #################

      # neodev-nvim # mini distribution to configure neovim

      # ctags are probably harder to manage than tree-sitter
      # tagbar # view tags/ctags
      # # view lsp symbols/tags
      # {
      #   plugin = vista-vim;
      #   config = ''
      #     " How each level is indented and what to prepend.
      #     let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
      
      #     " Executive used when opening vista sidebar without specifying it.
      #     " See all the avaliable executives via `:echo g:vista#executives`.
      #     " let g:vista_default_executive = 'ctags'
      
      #     " Set the executive for some filetypes explicitly. Use the explicit executive
      #     " instead of the default one for these filetypes when using `:Vista` without
      #     " specifying the executive.
      #     let g:vista_executive_for = {
      #       \ 'py': 'vim_lsp',
      #       \ }
      
      #     " To enable fzf's preview window set g:vista_fzf_preview.
      #     " The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
      #     " For example:
      #     let g:vista_fzf_preview = ['right:50%']
      #   '';
      # }
      
      # vim-script+rust. last update 2y
      # {
      #   plugin = LanguageClient-neovim;
      #   config = ''
      #     " Required for operations modifying multiple buffers like rename.
      #     set hidden
      
      #     let g:LanguageClient_serverCommands = {'python': ['/nix/store/2yl2pm26psl76nnddlj7vdmmk4qlhra6-user-environment/bin/pyright'],}
      
      #     " note that if you are using Plug mapping you should not use noremap mappings.
      #     nmap <F5> <Plug>(lcn-menu)
      #     " Or map each action separately
      #     nmap <silent>K <Plug>(lcn-hover)
      #     nmap <silent> gd <Plug>(lcn-definition)
      #     nmap <silent> <F2> <Plug>(lcn-rename)
      #   '';
      # }

      # vim-lsp # vimscript
      # ale # technically not lsp (linter) # maybe overkill
      # vimspector # older more traditional
      ];
  };
}
