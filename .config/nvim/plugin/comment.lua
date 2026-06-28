vim.pack.add({
  { src = "https://github.com/numToStr/Comment.nvim", version = vim.version.range("^0.8") },
})

require("Comment").setup()
