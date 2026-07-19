require("config.options")

require("user_commands.lsp")
require("user_commands.pack")

-- Enable builtin plugins
vim.cmd("packadd nvim.difftool")
vim.cmd("packadd nvim.undotree")
vim.cmd("packadd nohlsearch")
