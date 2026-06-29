vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim", version = vim.version.range("^9.0") },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/zapling/mason-conform.nvim", version = "main" },
}, { load = true })

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
    markdown = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    ["*"] = { "trim_whitespace" },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  conform.format(format_config)
end, { desc = "Format file or range (in visual mode)" })

require("mason-conform").setup()
