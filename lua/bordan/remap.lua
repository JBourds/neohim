-- Easy explore
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

-- Mimic tmux window controls with neovim tabs
vim.keymap.set("n", "<C-s>c", function()
	vim.cmd("tab split")
end, { noremap = true, desc = "'c' for splitting a tab like a tmux window" })
vim.keymap.set("n", "<C-s>x", function()
	vim.cmd("tabclose")
end, { noremap = true, desc = "'x' for deleting a tab like a tmux window" })

vim.keymap.set("n", "<C-s>p", function()
	vim.cmd("-tabnext")
end, { noremap = true, desc = "Go back one tab" })
vim.keymap.set("n", "<C-s>n", function()
	vim.cmd("+tabnext")
end, { noremap = true, desc = "Go forward one tab" })
vim.keymap.set("n", "<C-s>0", function()
	vim.cmd("1tabnext")
end, { noremap = true, desc = "Go to the first tab" })
vim.keymap.set("n", "<C-s>$", function()
	vim.cmd("$tabnext")
end, { noremap = true, desc = "Go to the last tab" })

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
