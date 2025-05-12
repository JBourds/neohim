return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				float = {
					show_header = true,
					source = "always",
					border = "rounded",
				},
			})

			vim.keymap.set("n", "?", function()
				vim.diagnostic.open_float(nil, { focusable = false })
			end, { silent = true, desc = "Show diagnostic float" })

			local function on_attach(_, bufnr)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
				end

				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "gd", vim.lsp.buf.definition, "Go to definition")
				map("n", "K", vim.lsp.buf.hover, "Hover documentation")
				map("n", "gr", vim.lsp.buf.references, "References")
				map("n", "gs", vim.lsp.buf.signature_help, "Signature help")
				map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
				map("n", "gt", vim.lsp.buf.type_definition, "Type definition")
				map("n", "<leader>gw", vim.lsp.buf.document_symbol, "Document symbols")
				map("n", "<leader>gW", vim.lsp.buf.workspace_symbol, "Workspace symbols")
				map("n", "<leader>ah", vim.lsp.buf.hover, "Hover help")
				map("n", "<leader>af", vim.lsp.buf.code_action, "Code action")
				map("n", "<leader>ar", vim.lsp.buf.rename, "Rename")
				map("n", "<leader>=", function()
					vim.lsp.buf.format({ async = true })
				end, "Format file")
				map("n", "<leader>ai", vim.lsp.buf.incoming_calls, "Incoming calls")
				map("n", "<leader>ao", vim.lsp.buf.outgoing_calls, "Outgoing calls")
				map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
				map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
			end

			-- Setup individual language servers
			local servers = {
				rust_analyzer = {},
				pyright = {},
				lua_ls = {},
				vale_ls = {},
				clangd = {},
			}

			for name, config in pairs(servers) do
				config.on_attach = on_attach
				lspconfig[name].setup(config)
			end
		end,
	},

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
		opts = {
			automatic_installation = true,
			ensure_installed = {
				"rust_analyzer",
				"pyright",
				"lua_ls",
				"vale_ls",
				"clangd",
				"gopls",
				"sqls",
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				-- LSP servers
				"rust_analyzer",
				"pyright",
				"lua-language-server",
				"vale_ls",
				"clangd",
				"gopls",
				"sqls",
				-- Formatters
				"black",
				"clang-format",
				"gofumpt",
				"goimports",
				"isort",
				"pgformatter",
				"ruff",
				"shfmt",
				"sqlfmt",
				"stylua",
				"typstyle",
				-- Linters
				"gofumpt",
				"cpplint",
				"golangci-lint",
				"markdownlint",
				"ruff",
				"golines",
				"gomodifytags",
				"gotests",
				"stylua",
				"shellcheck",
				"sqlfluff",
			},
			auto_update = true,
			run_on_start = true,
		},
	},
}
