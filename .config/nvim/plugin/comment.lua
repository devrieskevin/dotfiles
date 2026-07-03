vim.pack.add({
  { src = "https://github.com/numToStr/Comment.nvim", version = vim.version.range("^0.8") },
}, { load = true })

require("Comment").setup()
