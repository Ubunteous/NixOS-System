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
map("n", "m", "h", silentnoremap)
map("n", "n", "j", silentnoremap)
map("n", "e", "k", silentnoremap)
map("n", "i", "l", silentnoremap)

map("n", "h", "i", silentnoremap)
map("n", "j", "m", silentnoremap)
map("n", "k", "n", silentnoremap)
map("n", "l", "e", silentnoremap)

map("i", "jj", "<ESC>", silentnoremap)
map("i", "hh", "<ESC>", silentnoremap)
