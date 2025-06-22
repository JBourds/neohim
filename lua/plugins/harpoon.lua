return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		-- Cool extensions
		local harpoon_extensions = require("harpoon.extensions")
		harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		vim.keymap.set("n", "<leader>fh", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open harpoon window in telescope." })

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():append()
		end, { desc = "Add file to harpoon list." })
		-- Quick navigation to harpoon lists
		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end, { desc = "Shortcut to jump to first harpoon mark." })
		vim.keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end)
		vim.keymap.set("n", "<leader>5", function()
			harpoon:list():select(5)
		end)
		vim.keymap.set("n", "<leader>6", function()
			harpoon:list():select(6)
		end)
		vim.keymap.set("n", "<leader>7", function()
			harpoon:list():select(7)
		end)
		vim.keymap.set("n", "<leader>8", function()
			harpoon:list():select(8)
		end)
		vim.keymap.set("n", "<leader>9", function()
			harpoon:list():select(9)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():next()
		end, { desc = "Jump to the next harpoon mark." })
		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { desc = "Jump to the previous harpoon mark." })
	end,
}
