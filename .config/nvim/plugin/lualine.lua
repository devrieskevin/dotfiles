vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim", version = "master" },
}, { load = true })

require("lualine").setup({
  extensions = { "aerial", "avante", "quickfix" },
})
