return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- dap.adapters.php = {
      --   type = "executable",
      --   command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
      --   args = {},
      -- }

      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
      }

      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003,
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },
}
