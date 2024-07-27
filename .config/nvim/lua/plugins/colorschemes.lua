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
    priority = 1000,
    config = function()
      local catppuccin = require("catppuccin")

      catppuccin.setup({
        flavour = "mocha",
        custom_highlights = function(colors)
          return {
            WinSeparator = { fg = colors.surface0 },
          }
        end,
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
