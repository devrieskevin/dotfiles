return {
  {
    "mfussenegger/nvim-dap",
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
          name = "Listen for Xdebug",
          port = 9003,
        },
      }

      dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/debugpy-adapter",
        args = {},
      }

      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = "launch",
          name = "Launch file",

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
          name = "Launch file",
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

      -- Rust launch.json config might not work due to nvim-dap trying to be language agnostic.
      -- This is specifically the case for when the cargo attribute is used instead of the program attribute.
      -- See https://github.com/mfussenegger/nvim-dap/discussions/671
      -- TODO: See if using rustaceans.nvim can help with this.
      require("dap.ext.vscode").load_launchjs(nil, {
        lldb = { "rust", "cpp", "c" },
      })

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
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dapui").setup()

      vim.keymap.set("n", "<leader>dt", function()
        require("dapui").toggle()
      end, { desc = "Toggle DAP UI" })
    end,
  },
}
