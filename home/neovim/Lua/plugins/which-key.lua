return {
	{
		"folke/which-key.nvim",
		lazy = true,
		-- opts = {
		-- 	defaults = {
		-- 		["<leader>d"] = { name = "+debug" },
		-- 	},
		-- },

		keys = {
			{ "<leader>", "<cmd>WhichKey<cr>", desc = "Which-Key" },
		},

		config = function()
			-- set timeout for which-key
			vim.opt.timeoutlen = 300 -- 1000ms by default

			-- vim.g.mapleader = " "
			-- vim.g.maplocalleader = ","

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
				   a = { "<cmd>Lazy<cr>", "Lazy Menu" },
				   s = { "<cmd>w<cr>", "Save" },
				   q = { "<cmd>q<cr>", "Quit" },
				},
			})
		end,
	},
}
