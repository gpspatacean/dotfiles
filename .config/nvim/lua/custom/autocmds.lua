-- Do not show line numbers in the terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- Custom LazyGit Launcher, because
-- 1) lazygit doesn't get along with powershell
-- 2) j/k terminal map messes up j/k navigation in lazygit
-- These are resetted in lazygit_on_exit_callback
vim.api.nvim_create_user_command("LaunchLazyGit", function()
  if vim.fn.has("win32") then
    vim.o.shell = "cmd.exe"
  end

  vim.keymap.del("t", "jk")

  vim.cmd("LazyGit")
end, {})
