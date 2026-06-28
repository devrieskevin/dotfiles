vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim", version = "master" },
})

require("lualine").setup({
  options = {
    theme = "catppuccin",
  },
  extensions = { "aerial", "avante", "quickfix" },
})
