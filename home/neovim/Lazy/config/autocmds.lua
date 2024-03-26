local au_dynacase = vim.api.nvim_create_augroup("dynacase", { clear = true })

vim.api.nvim_create_autocmd("CmdLineEnter", {
			       command = "set nosmartcase",
			       group = au_dynacase,
})

vim.api.nvim_create_autocmd("CmdLineLeave", {
			       command = "set smartcase",
			       group = au_dynacase,
})

-- change dir to current buffer
vim.api.nvim_create_autocmd("BufEnter", { command = "silent! lcd %:p:h" })
