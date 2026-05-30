return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = function() vim.fn["mkdp#util#install"]() end,
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        "chomosuke/typst-preview.nvim",
        lazy = true,
        version = "1.*",
        opts = {},
    },
}
