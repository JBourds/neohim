return {
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                { "<BS>",      desc = "Decrement Selection", mode = "x" },
                { "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        config = function()
            local ensureInstalled = {
                "lua", "python", "typescript", "markdown", "rust", "c", "cpp",
                "javascript", "html", "bash", "asm", "json", "go",
            }
            local alreadyInstalled = require("nvim-treesitter").get_installed()
            local parsersToInstall = vim.iter(ensureInstalled)
                :filter(function(parser)
                    return not vim.tbl_contains(alreadyInstalled, parser)
                end)
                :totable()
            if #parsersToInstall > 0 then
                require("nvim-treesitter").install(parsersToInstall)
            end

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
    },
}
