return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")

      local builtin = require("telescope.builtin")

      local search_in_directory_with = function(finder)
        return function(_)
          local action_state = require("telescope.actions.state")
          local fb = require("telescope").extensions.file_browser
          local current_line = action_state.get_current_line()

          fb.file_browser({
            files = false,
            depth = false,
            attach_mappings = function(_)
              require("telescope.actions").select_default:replace(function()
                local entry_path = action_state.get_selected_entry().Path
                local dir = entry_path:is_dir() and entry_path or entry_path:parent()
                local relative = dir:make_relative(vim.fn.getcwd())
                local absolute = dir:absolute()

                finder({
                  results_title = relative .. "/",
                  cwd = absolute,
                  default_text = current_line,
                })
              end)

              return true
            end,
          })
        end
      end

      telescope.setup({
        pickers = {
          find_files = {
            mappings = {
              i = {
                ["<C-f>"] = search_in_directory_with(builtin.find_files),
              },
              n = {
                ["<C-f>"] = search_in_directory_with(builtin.find_files),
              },
            },
            find_command = {
              "rg",
              "--hidden",
              "--files",
              "-g",
              "!**/.git/*",
            },
          },
          live_grep = {
            mappings = {
              i = {
                ["<C-f>"] = search_in_directory_with(builtin.live_grep),
              },
              n = {
                ["<C-f>"] = search_in_directory_with(builtin.live_grep),
              },
            },
            additional_args = {
              "--hidden",
              "-g",
              "!**/.git/*",
            },
          },
        },
      })

      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>FF", function()
        local current_opts = {
          find_command = {
            "rg",
            "--no-ignore",
            "--hidden",
            "--files",
            "-g",
            "!**/.git/*",
          },
        }

        local find_files = function(opts)
          return builtin.find_files(vim.tbl_deep_extend("force", current_opts, opts or {}))
        end

        current_opts.attach_mappings = function(_, map)
          map("i", "<C-f>", search_in_directory_with(find_files))
          map("n", "<C-f>", search_in_directory_with(find_files))
          return true
        end

        return find_files()
      end, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})

      vim.keymap.set("n", "<leader>fb", function()
        telescope.extensions.file_browser.file_browser()
      end)

      -- Set `fd` as an alias for `find_files` again
      builtin.fd = builtin.find_files
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
}
