return {
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")

      local format_config = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
      }

      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          twig = { "djlint", "twig-cs-fixer" },
          python = { "ruff_fix", "ruff_format", "isort" },
          rust = { "rustfmt" },
          ["*"] = { "trim_whitespace" },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        conform.format(format_config)
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  {
    "zapling/mason-conform.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "stevearc/conform.nvim" },
    },
    config = function()
      require("mason-conform").setup()
    end,
  },
}
