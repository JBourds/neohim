require("bordan.remap")
require("bordan.set")
require("bordan.urls")
require("mason").setup()
require("mason-nvim-dap").setup()

vim.cmd("colorscheme kanagawa-wave")
vim.g.mkdp_theme = "dark"
vim.opt.clipboard = "unnamedplus"
