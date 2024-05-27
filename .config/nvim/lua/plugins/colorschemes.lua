return {
  {
    "folke/tokyonight.nvim",
    config = function()
      local tokyonight = require("tokyonight")

      tokyonight.setup({
        style = "night",
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      local catppuccin = require("catppuccin")

      catppuccin.setup({
        flavour = "mocha",
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
