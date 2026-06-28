return {
  "numToStr/Comment.nvim",
  version = "^0.8",
  enabled = false,
  lazy = false,
  config = function()
    require("Comment").setup()
  end,
}
