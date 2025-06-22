return {
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
		config = function()
			require("leap")
			vim.keymap.set({ "n", "x", "o" }, "<leader>l", "<Plug>(leap)")
			vim.keymap.set("n", "<leader>L", "<Plug>(leap-from-window)")
		end,
	},
}
