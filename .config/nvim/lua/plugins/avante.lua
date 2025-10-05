return {
  "yetone/avante.nvim",
  -- enabled = false,
  event = "VeryLazy",
  branch = "main",
  opts = {
    provider = "copilot",
    providers = {
      ollama = {
        model = "granite-code:3b",
        is_env_set = function ()
          local Providers = require("avante.providers")
          local ok, _ = pcall(function () return Providers.ollama:models_list() end)
          return ok
        end,
      },
      copilot = {
        model = "claude-3.7-sonnet",
      },
    },
    hints = {
      enabled = false,
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "Avante" },
      },
      ft = { "Avante" },
    },
  },
}
