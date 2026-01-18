-- Really slow to open on fish without this line
vim.opt.shell = "/bin/bash"
vim.o.termguicolors = true
require("config.lazy")
require("bordan")
