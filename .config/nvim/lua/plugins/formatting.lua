return {
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")

      local format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }

      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          ["*"] = { "trim_whitespace" },
        },
        format_on_save = format_on_save,
      })

      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        conform.format(format_on_save)
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
}
