return {
    {
        'brianhuster/live-preview.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('livepreview.config').set({ dynamic_root = true })
        end
    },
    {
        "chomosuke/typst-preview.nvim",
        lazy = true,
        version = "1.*",
        opts = {},
    },
}
