return {
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim", lazy = true },
    keys = {
      {
        "<leader>yt",
        mode = { "n", "v" },
        "<cmd>LaunchYazi toggle<cr>",
        desc = "Toggle same yazi session",
      },
      {
        "<leader>yc",
        mode = { "n", "v" },
        "<cmd>LaunchYazi current<cr>",
        desc = "Open yazi in the current file`s directory",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
      hooks = {
        yazi_opened = function(preselected_path, yazi_buffer_id, config) end,

        yazi_closed_successfully = function(chosen_file, config, state)
          if vim.fn.has("win32") == 1 then
            vim.o.shell = "powershell.exe"
          end

          vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = 'Exit terminal mode with "jk"' })
        end,

        yazi_opened_multiple_files = function(chosen_files, config, state) end,
      },
    },
  },
}
