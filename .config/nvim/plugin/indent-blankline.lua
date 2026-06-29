vim.pack.add({
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim", version = vim.version.range("^3.8") },
}, { load = true })

require("ibl").setup({
  indent = { char = "┊" },
})
