--###########
--#  REMAP  #
--###########

local function map(kind, lhs, rhs, opts)
	vim.api.nvim_set_keymap(kind, lhs, rhs, opts)
end

local silentnoremap = { noremap = true, silent = true }

-- m: record current line/position as mark / M: move middle of screen => j
-- n: repeat the search in the same direction / N: opposite => k
-- e: move to end of word / E: end  of token => m
-- i: insert mode / I: at beginning line => l

-- note: nnoremap only remaps single keys
-- (e.g.: ciw behaves as default but i does not)
-- use noremap with a single n for a full remap

-- NORMAL
map("n", "m", "h", silentnoremap)
map("n", "n", "j", silentnoremap)
map("n", "e", "k", silentnoremap)
map("n", "i", "l", silentnoremap)

map("n", "h", "u", silentnoremap)
map("n", "u", "i", silentnoremap)

map("n", "j", "m", silentnoremap)
map("n", "k", "n", silentnoremap)
map("n", "l", "e", silentnoremap)

-- insert newline above/below (no leader, keep cursor position)
map("n", "oo", "m`o<Esc>``", silentnoremap)
map("n", "OO", "m`O<Esc>``", silentnoremap)

-- VISUAL
map("v", "m", "h", silentnoremap)
map("v", "n", "j", silentnoremap)
map("v", "e", "k", silentnoremap)
map("v", "i", "l", silentnoremap)

map("v", "h", "u", silentnoremap)
map("v", "u", "i", silentnoremap)

map("v", "j", "m", silentnoremap)
map("v", "k", "n", silentnoremap)
map("v", "l", "e", silentnoremap)

-- ESCAPE
-- map("i", "jj", "<ESC>", silentnoremap)
-- map("i", "hh", "<ESC>", silentnoremap)
-- map("i", "mn", "<ESC>", silentnoremap)
-- map("i", "gm", "<ESC>", silentnoremap)
map("i", "nn", "<ESC>", silentnoremap)

-- BUFFERS (convert to lua)
-- nnoremap <silent> [b :bprevious<CR>
-- nnoremap <silent> ]b :bnext<CR>
-- nnoremap <silent> [B :bfirst<CR>
-- nnoremap <silent> ]B :blast<CR>

--#############
--#  OPTIONS  #
--#############

-- CONVERSION GUIDE
-- let g:foo = bar => vim.g.foo = bar
-- set foo = bar => vim.opt.foo = bar (note: set foo = vim.opt.foo = true)
-- some_vimscript => vim.cmd(some_vimscript)

-- use either to show line numbers on the left
vim.opt.number = true
-- vim.opt.relativenumber = true

-- vim.opt.foldlevel = 99
vim.opt.foldenable = false -- prevent fold on file open
vim.opt.foldmethod = "indent"

-- remove ~ at end of empty lines
vim.wo.fillchars = "eob: "

-- arrow keys and backspace don't get stuck on bol/eol
-- do not use this config with hjkl or plugs will break
vim.opt.whichwrap:append("bs<>[]")
vim.opt.backspace = { "indent", "eol", "start" }

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

-- -- time to input rest of a command
-- vim.opt.timeoutlen = 200

-- ignore case when entering command
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- better find file => does not do much
-- vim.opt.autochdir = true
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full,full"

--##################
--#  AUTOCOMMANDS  #
--##################

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
