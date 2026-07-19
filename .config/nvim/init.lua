require("config.options")

require("autocmds.lsp")

-- Enable builtin plugins
vim.cmd("packadd nvim.difftool")
vim.cmd("packadd nvim.undotree")
vim.cmd("packadd nohlsearch")
