return {
	{
		"python-mode/python-mode",
		-- event = "BufEnter *.py",
		ft = "python", -- get filetype with :set filetype?

		config = function()
			vim.g.pymode_lint = 0

			-- open splits vertically
			vim.api.nvim_create_autocmd("BufEnter", { pattern = { "__run__", "__doc__" }, command = "wincmd L" })

			-- remove ugly vertical bar
			vim.g.pymode_options_colorcolumn = 0

			vim.g.pymode_run_bind = "<leader>p" -- default is r
			vim.keymap.set("i", "<C-l>", "<cmd>PymodeRun<cr>", { noremap = true, silent = true })

			-- -- if you want to use overlay feature
			-- vim.g.choosewin_overlay_enable = 1
		end,
	},
}
