-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')
    -- LSP
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    -- Linting and Formatting
    use('mfussenegger/nvim-lint')
    use('stevearc/conform.nvim')

    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    -- use 'hrsh7th/cmp-buffer'
    -- use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    -- Snippet engines
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- Debugging: Not currently used
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Hex editor
    use('RaafatTurki/hex.nvim')

    -- Colorscheme
    use('rebelot/kanagawa.nvim')

    -- Break code into AST for easier use by LSP
    use(
        'nvim-treesitter/nvim-treesitter',
        {
            run = ':TSUpdate',
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = { "markdown", "markdown_inline", "python", "rust", "json", "r", "rnoweb", "yaml", "latex", "csv" },
                    highlight = { enable = true },
                })
            end
        }

    )
    use('nvim-treesitter/playground')

    -- Undo
    use('mbbill/undotree')

    -- Git wrapper
    use('tpope/vim-fugitive')

    -- Markdown preview
    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
    })
    use({
        "R-nvim/R.nvim",
    })
    use({
        "R-nvim/cmp-r",
        {
            "hrsh7th/nvim-cmp",
            config = function()
                require("cmp").setup({ sources = { { name = "cmp_r" } } })
                require("cmp_r").setup({})
            end,
        },
    })
end)
