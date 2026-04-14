return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "ruff" },
            typst = { "typstyle" },
            shell = { "shfmt" },
            c = { "clangd-format" },
            cpp = { "clangd-format" },
            go = { "gofumpt", "goimports" },
            sql = { "pgformatter" },
            markdown = { "markdownlint" },
            rust = { "rustfmt" },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 500 },
        -- Customize formatters
        formatters = {
            shfmt = {
                prepend_args = { "-i", "2" },
            },
            pg_format = {
                args = { "--keyword-case", "UPPER" },
                stdin = true,
            },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
