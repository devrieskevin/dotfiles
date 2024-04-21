return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        lua = { "luacheck" },
        python = { "ruff" },
        php = { "phpstan" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    "rshkarin/mason-nvim-lint",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "mfussenegger/nvim-lint" },
    },
    config = function()
      require("mason-nvim-lint").setup({
        ensure_installed = {
          "luacheck",
          "ruff",
          "phpstan",
        },
      })
    end,
  },
}
