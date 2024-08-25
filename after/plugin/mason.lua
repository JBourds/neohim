-- Setup Mason to easily install LSP servers
require('mason').setup()
require('mason-lspconfig').setup{
    ensure_installed = { 'lua_ls', 'marksman', 'rust_analyzer', 'pyright' }
}
