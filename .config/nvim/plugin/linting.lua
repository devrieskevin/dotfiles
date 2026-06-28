vim.pack.add({
  { src = "https://github.com/mfussenegger/nvim-lint", version = "master" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/rshkarin/mason-nvim-lint", version = vim.version.range("^0.1") },
})

local lint = require("lint")

lint.linters_by_ft = {
  lua = { "luacheck" },
  python = { "ruff" },
  php = { "phpstan" },
  javascript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
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

require("mason-nvim-lint").setup({
  ensure_installed = {
    "luacheck",
    "ruff",
    "phpstan",
    "eslint_d",
  },
})
