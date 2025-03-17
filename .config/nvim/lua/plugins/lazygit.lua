return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<leader>lg", "<cmd>LaunchLazyGit<cr>", desc = "Open lazy git" }, -- use custom LaunchLazyGit command
  },
  config = function()
    vim.g.lazygit_on_exit_callback = function()
      vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = 'Exit terminal mode with "jk"' })
      if vim.fn.has'win32' == 1 then
        vim.o.shell = "powershell.exe"
      end
    end
  end,
}
