-- Autocomplete
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        -- Uncomment to use bordered windows
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- Uncomment for `vsnip` users
    }, {
        { name = 'buffer' },
    })
})

-- Optional: Uncomment and configure if using git with cmp
-- require("cmp_git").setup()
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'git' },
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- Configure cmdline sources
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig
local capabilities = require('cmp_nvim_lsp').default_capabilities()


local function map(mode, lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

local lspconfig = require('lspconfig')

local custom_attach = function(client)
    print("LSP started.");

    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    map('n', '<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    map('n', '<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
    map('n', '<leader>ah', '<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n', '<leader>af', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    map('n', '<leader>ee', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
    map('n', '<leader>ar', '<cmd>lua vim.lsp.buf.rename()<CR>')
    map('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    map('n', '<leader>ai', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
    map('n', '<leader>ao', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
end

lspconfig.pyright.setup { on_attach = custom_attach }
lspconfig.lua_ls.setup {}
lspconfig.rust_analyzer.setup {
    settings = {
        ["rust-analyzer"] = {
            -- Other Settings ...
            procMacro = {
                ignored = {
                    leptos_macro = {
                        -- optional: --
                        -- "component",
                        "server",
                    },
                },
            },
        },
    },
    on_attach = custom_attach
}
lspconfig.vale_ls.setup { on_attach = custom_attach }
