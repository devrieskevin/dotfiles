return {
  {
    "nvim-lualine/lualine.nvim",
    branch = "master",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", opt = true },
    },
    opts = {
      options = {
        theme = "catppuccin",
      },
      extensions = { "aerial", "avante", "quickfix" },
    },
  },
}
