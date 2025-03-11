-- Set map leader to be easily accessible
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Explore)

-- Keybindings for Markdown preview
vim.api.nvim_set_keymap('n', '<leader>mp', ':MarkdownPreview<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mP', ':MarkdownPreviewStop<CR>', { noremap = true, silent = true })

-- Keybinding for wrapping current word or line in parentheses
vim.keymap.set("n", "<leader>ww", "bi(<C-c>ea)<C-c>%i", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>wl", "^i(<C-c>$a)<C-c>%i", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>wW", "Bi(<C-c>Ea)<C-c>%i", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>wbw", "bi{<C-c>ea}<C-c>%i", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>wbW", "Bi{<C-c>Ea}<C-c>%i", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>wbl", "^i{<C-c>$a}<C-c>%i", { noremap = true, silent = true })

-- Easier to delete without overwriting default refister
vim.keymap.set("v", "<leader>d", "\"_d", { noremap = true, silent = true })

-- "Fix" (delete into blackhole and replace with buffer)
-- In normal mode, use heuristic to go to end of word
-- In visual mode, do it on highlighted text
vim.keymap.set("n", "<leader>f", "\"_cw<Esc>p", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>f", "\"_dp", { noremap = true, silent = true })

-- Easier macro replay
vim.keymap.set("n", ".", "@@", { noremap = true, silent = true })

-- Very important
vim.keymap.set("n", "<leader>l", function()
    print('Time to link in 😎')
    open_linkedin()
end, { noremap = true })

-- Move highlighted region under/over next line
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
-- Quicker paging with cursor staying in place
vim.keymap.set("n", "<C-j>", "<C-d>zz")
vim.keymap.set("n", "<C-k>", "<C-u>zz")

-- Some kind of pattern matching?
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Make terminal navigation easier
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Easier to leave insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>")
-- Keymap for manual formatting
vim.keymap.set({ "n", "v" }, "<leader>f", function()
    require('conform').format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    })
end, { desc = "Format file or range (in visual mode)" })

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

-- Hex dump commands
vim.keymap.set({ "n" }, "<leader>dt", function()
    require('hex').toggle()
end)
vim.keymap.set({ "n" }, "<leader>da", function()
    require('hex').assemble()
end)
vim.keymap.set({ "n" }, "<leader>du", function()
    require('hex').dump()
end)

-- Debug keybindings (https://github.com/letsgetrusty/neovim-rust/)
vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
    { desc = "Debugger toggle breakpoint" })
local debug_called = false

vim.keymap.set("n", "<leader>dc", function()
    if not debug_called then
        -- Try calling RustLsp debuggables only the first time
        local success = pcall(vim.cmd.RustLsp, "debuggables")
        if success then
            debug_called = true
        else
            -- If RustLsp fails, fall back to DapContinue
            vim.cmd.DapContinue()
        end
    else
        -- After the first call, just continue debugging
        vim.cmd.DapContinue()
    end
end)
vim.keymap.set(
    "n",
    "<leader>scb",
    "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    { desc = "Debugger set conditional breakpoint" }
)
vim.keymap.set("n", "<leader>dq", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger Quit" })
vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger Restart" })

-- rustaceanvim
vim.keymap.set("n", "<leader>dt", "<cmd>lua vim.cmd('RustTest')<CR>", { desc = "Debugger testables" })
