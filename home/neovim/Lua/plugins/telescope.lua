return {
   "nvim-telescope/telescope.nvim",
   lazy = true,

   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
   },

	keys = {
	   -- add a keymap to browse plugin files
	   {
	      "<leader>ff",
	      function()
		 require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
	      end,
	      desc = "Find Plugin File",
	   },
	},
	-- change some options
	opts = {
	   defaults = {
	      layout_strategy = "horizontal",
	      layout_config = { prompt_position = "top" },
	      sorting_strategy = "ascending",
	      winblend = 0,
	   },
	},
	config = function()
	   local wk = require("which-key")
	   -- local builtin = require('telescope.builtin')
	   -- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

	   wk.register({
		 ["<leader>f"] = {
		    name = "telescope",
		    f = { "<cmd>Telescope find_files<cr>", "Telescope Find Files" },
		    c = {
		       function()
			  builtin.find_files({ cwd = utils.buffer_dir() })
		       end,
		       "Find files in cwd",
		    },
		    g = { "<cmd>Telescope live_grep<cr>", "Telescope Live Grep" },
		    b = { "<cmd>Telescope buffers<cr>", "Telescope Buffers" },
		    h = { "<cmd>Telescope help_tags<cr>", "Telescope Help Tags" },
		 },
	   })
	end,
}
