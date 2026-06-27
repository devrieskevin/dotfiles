vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
    version = vim.version.range("^2.0"),
  },
})

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
  },
})

vim.cmd.colorscheme("catppuccin")
