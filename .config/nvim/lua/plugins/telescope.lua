return {
  {
    "nvim-telescope/telescope.nvim",
    version = "^0.1",
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
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})

      local function find_all_files(opts)
        local current_opts = {
          find_command = {
            "rg",
            "--no-ignore",
            "--hidden",
            "--files",
            "-g",
            "!**/.git/*",
          },
          attach_mappings = function(_, map)
            map("i", "<C-f>", search_in_directory_with(find_all_files))
            map("n", "<C-f>", search_in_directory_with(find_all_files))
            return true
          end,
        }

        return builtin.find_files(vim.tbl_deep_extend("force", current_opts, opts or {}))
      end
      vim.keymap.set("n", "<leader>FF", find_all_files, {})

      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

      local function live_grep_all(opts)
        local current_opts = {
          additional_args = {
            "--no-ignore",
            "--hidden",
            "-g",
            "!**/.git/*",
          },
          attach_mappings = function(_, map)
            map("i", "<C-f>", search_in_directory_with(live_grep_all))
            map("n", "<C-f>", search_in_directory_with(live_grep_all))
            return true
          end,
        }

        return builtin.live_grep(vim.tbl_deep_extend("force", current_opts, opts or {}))
      end
      vim.keymap.set("n", "<leader>FG", live_grep_all, {})

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
    branch = "master",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    branch = "master",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },
}
