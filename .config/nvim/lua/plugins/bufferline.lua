return {
  {
    "akinsho/bufferline.nvim",
    version = "^4.3",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      require("bufferline").setup({})
    end,
  },
}
