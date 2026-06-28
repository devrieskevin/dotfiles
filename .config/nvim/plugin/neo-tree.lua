vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("^3.31") },
})

local neotree = require("neo-tree")

neotree.setup({
  window = {
    position = "float",
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },
})

vim.keymap.set("n", "<leader>nn", "<Cmd>Neotree toggle<CR>")
vim.keymap.set("n", "<leader>nr", "<Cmd>Neotree reveal<CR>")
vim.keymap.set("n", "<leader>nb", "<Cmd>Neotree buffers<CR>")
