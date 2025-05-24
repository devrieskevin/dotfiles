return {
  {
    "folke/tokyonight.nvim",
    version = "^4.11",
    config = function()
      local tokyonight = require("tokyonight")

      tokyonight.setup({
        style = "night",
      })
    end,
  },
  {
    "catppuccin/nvim",
    version = "^1.9",
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
        integrations = {
          aerial = true,
          harpoon = true,
        }
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
