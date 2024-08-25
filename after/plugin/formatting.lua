-- Linting

local lint = require('lint')

lint.linters_by_ft = {
    markdown = { "markdownlint", "vale" },
    yaml = { "yamllint" },
    python = { 'pylint' },
    rust = { 'clippy' },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
        lint.try_lint()
    end,
})

vim.keymap.set("n", "<leader>ll", function()
    lint.try_lint()
end, { desc = "Trigger linting for current file" })

-- Formatting

local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "autopep8", "isort" }, -- or "autopep8" if preferred
        rust = { "rustywind" },
        json = { "prettier" },            -- Prettier for JSON files
        yaml = { "prettier" },            -- Prettier for YAML files (if preferred)
        toml = { "taplo" },               -- Taplo for TOML files
        markdown = { "prettier" },        -- Prettier for Markdown files
        text = { "prettier" },            -- Prettier for plain text files
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
})
