return {
    {
        'brianhuster/live-preview.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('livepreview.config').set()
        end
    },
    {
        "chomosuke/typst-preview.nvim",
        lazy = false, -- or ft = 'typst'
        version = "1.*",
        opts = {},    -- lazy.nvim will implicitly calls `setup {}`
    },
}
