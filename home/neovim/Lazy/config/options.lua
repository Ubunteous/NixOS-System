-- CONVERSION GUIDE
-- let g:foo = bar => vim.g.foo = bar
-- set foo = bar => vim.opt.foo = bar (note: set foo = vim.opt.foo = true)
-- some_vimscript => vim.cmd(some_vimscript)

-- use either to show line numbers on the left
vim.opt.number = true
-- vim.opt.relativenumber = true

-- remove ~ at end of empty lines
vim.wo.fillchars = "eob: "

-- arrow keys and backspace don't get stuck on bol/eol
-- do not use this config with hjkl or plugs will break
vim.opt.whichwrap:append("bs<>[]")
vim.opt.backspace = { "indent", "eol", "start" }

-- ----
-- -- " hide ~ on empty lines
-- -- hi NonText guifg = bg

-- see whitespaces
-- vim.opt.listchars["trail"] = "•"
vim.opt.listchars = {
	eol = "⤶",
	space = "❤",
	tab = "> ", -- needs 2 chars
	nbsp = "␣",
	trail = "•", -- +
	extends = "◀", -- ⟩
	precedes = "▶", -- ⟨
}

-- ignore case when entering command
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- better find file => does not do much
-- vim.opt.autochdir = true
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full,full"
