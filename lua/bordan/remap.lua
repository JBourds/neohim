-- Goated mapleader
vim.g.mapleader = " "

-- Easy explor
vim.keymap.set("n", "<leader>pv", vim.cmd.Explore)

-- My own super special motions which allow me to avoid clobbering the system
-- clipboard when deleting a text object
vim.keymap.set("n", "<leader>d", '"_d', { noremap = true })
vim.keymap.set("v", "<leader>d", '"_d', { noremap = true })

-- Overwrite visually selected text without copying it into yank buffer
-- TODO: Make a version of this which accepts a motion in normal mode.
vim.keymap.set("v", "<leader>f", '"_dp', { noremap = true })

-- Move highlighted region under/over next line
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Collapse next line into end of current line
vim.keymap.set("n", "J", "mzJ`z")

-- Get the nth occurence of the latest "/" or "?" search (on whole selection
-- rather than just the word matched by * and #)
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Easier to leave insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
