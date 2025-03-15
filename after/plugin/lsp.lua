-- Autocomplete
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.scroll_docs(-4),
        ['<C-k>'] = cmp.mapping.scroll_docs(4),
        ['<C-Enter>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }, {
        { name = 'buffer' },
    })
})

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

-- Ignore annoying 32802 error from typing fast
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

-- lspconfig keybinds
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
    map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
end

-- Make this plugin work the same as other LSPs
vim.g.rustaceanvim = {
    server = {
        on_attach = custom_attach
    }
}
local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
    "n",
    "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    function()
        vim.cmd.RustLsp({ 'hover', 'actions' })
    end,
    { silent = true, buffer = bufnr }
)

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    float = {
        show_header = true,
        source = "always",
        border = "rounded",
    },
})

-- Let us see diagnostic information displayed where it doesn't go off screen
map('n', '?', '<cmd>lua vim.diagnostic.open_float(nul, { focusable = false })<CR>')

lspconfig.pyright.setup { on_attach = custom_attach }
lspconfig.lua_ls.setup { on_attach = custom_attach }
lspconfig.vale_ls.setup { on_attach = custom_attach }
lspconfig.clangd.setup { on_attach = custom_attch }

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = true, -- Disable virtual text
    signs = true,        -- Enable signs (optional)
    float = {
        show_header = true,
        source = "always",
        border = "rounded", -- Border style for the float
    },
})
