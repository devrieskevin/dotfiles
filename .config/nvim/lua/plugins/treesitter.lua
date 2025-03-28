return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = "^0.9",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "elixir",
          "heex",
          "javascript",
          "typescript",
          "html",
          "python",
          "twig",
          "php",
          "sql",
          "rust",
          "css",
          "scss",
          "yaml",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })

      -- Treesitter folding implementation taken from: https://stackoverflow.com/a/79405264.
      vim.api.nvim_create_autocmd({ "FileType" }, {
        callback = function()
          -- check if treesitter has parser
          if require("nvim-treesitter.parsers").has_parser() then
            -- use treesitter folding
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
          else
            -- use alternative foldmethod
            vim.opt.foldmethod = "syntax"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "master",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "<c-v>",
            },
            include_surrounding_whitespace = true,
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>s"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>S"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[s"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
              ["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold" },
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
            },
          },
          lsp_interop = {
            enable = true,
            floating_preview_opts = { border = "single" },
            peek_definition_code = {
              ["<leader>tf"] = "@function.outer",
              ["<leader>tF"] = "@class.outer",
            },
          },
        },
      })
    end,
  },
}
