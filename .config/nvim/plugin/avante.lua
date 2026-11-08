vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "avante.nvim" and (kind == "install" or kind == "update") then
      -- compile avante rust libraries yourself
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
      -- or restart neovim and call `:AvanteBuild` to download prebuilt libraries
    end
  end,
})

vim.pack.add({
  -- Deps
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/ColinKennedy/mega.logging",
  "https://github.com/ColinKennedy/mega.cmdparse",

  -- Optional deps
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/nvim-tree/nvim-web-devicons", -- or 'echasnovski/mini.icons'
  "https://github.com/HakonHarnes/img-clip.nvim",
  "https://github.com/zbirenbaum/copilot.lua",
  "https://github.com/folke/snacks.nvim", -- for modern input UI

  {
    src = "https://github.com/avante-corp/avante.nvim",
    version = vim.version.range("^0.5"),
  },
})

-- Config customizations
require("avante").setup({
  provider = "ollama",
  providers = {
    ollama = {
      model = "gemma4:12b",
      is_env_set = require("avante.providers.ollama").check_endpoint_alive,
    },
  },
})
