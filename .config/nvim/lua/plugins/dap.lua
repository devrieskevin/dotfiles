return {
  {
    "mfussenegger/nvim-dap",
    version = "^0.10",
    config = function()
      local dap = require("dap")

      dap.adapters.php = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
        args = {},
      }

      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug (nvim-dap)",
          port = 9003,
        },
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug with DDEV (nvim-dap)",
          hostname = "0.0.0.0",
          port = 9003,
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
        },
      }

      dap.adapters.debugpy = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/debugpy-adapter",
        args = {},
      }

      -- Define python adapter as both `python` and `debugpy` for vscode compatibility
      dap.adapters.python = dap.adapters.debugpy

      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = "launch",
          name = "Launch file (nvim-dap)",

          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

          program = "${file}", -- This configuration will launch the current file if used.
          pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
              return cwd .. "/venv/bin/python"
            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
              return cwd .. "/.venv/bin/python"
            else
              return "/usr/bin/python"
            end
          end,
        },
      }

      dap.adapters.lldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.rust = {
        {
          name = "Launch file (nvim-dap)",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      vim.keymap.set("n", "<leader>db", function()
        dap.toggle_breakpoint()
      end, { desc = "Toggle breakpoint" })

      vim.keymap.set("n", "<leader>dc", function()
        dap.continue()
      end, { desc = "Start or continue from breakpoint" })

      vim.keymap.set("n", "<leader>do", function()
        dap.step_over()
      end, { desc = "Step over" })

      vim.keymap.set("n", "<leader>di", function()
        dap.step_into()
      end, { desc = "Step into" })

      vim.keymap.set("n", "<leader>dr", function()
        dap.repl.open()
      end, { desc = "Step out" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    branch = "master",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dapui").setup({
        layouts = {
          {
            elements = {
              {
                id = "watches",
                size = 0.0,
              },
              {
                id = "breakpoints",
                size = 0.1,
              },
              {
                id = "stacks",
                size = 0.1,
              },
              {
                id = "scopes",
                size = 0.8,
              },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              {
                id = "repl",
                size = 0.5,
              },
              {
                id = "console",
                size = 0.5,
              },
            },
            position = "bottom",
            size = 10,
          },
        },
      })

      vim.keymap.set("n", "<leader>dd", function()
        require("dapui").toggle()
      end, { desc = "Toggle DAP UI" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    version = "^2.4",
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "python",
          "php",
          "codelldb",
        },
      })
    end,
  },
}
