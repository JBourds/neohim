-- Set map leader to be easily accessible
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Make going to the end of lines easier
vim.keymap.set({"n", "v"}, "9", "$")

-- I just prefer this to keyboard motions (test these on Mac)
vim.keymap.set({"n", "v"}, "<C-Left>", "B")
vim.keymap.set({"n", "v"}, "<C-Right>", "E")

-- Very important
vim.keymap.set("n", "<leader>l", function() 
    open_linkedin() 
end, {noremap = true})

-- Move highlighted region under/over next line
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
-- Quicker paging with cursor staying in place
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Some kind of pattern matching?
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Make terminal navigation easier
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Easier to leave insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- What do these do?
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")



