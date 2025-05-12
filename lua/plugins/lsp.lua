return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = {
		ensure_installed = {
			"rust_analyzer",
			"python-lsp-server",
			"lua_ls",
			"gopls",
			"sqls",
			"clangd",
		},
		automatic_installation = true,
	},
	config = function(_, opts)
		require("mason").setup()
		require("mason-lspconfig").setup({ automatic_installation = true })
		require("mason-tool-installer").setup(opts)
	end,
}
