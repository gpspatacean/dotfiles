-- Wrappers over other plugins/APIs for more customization

-- Custom LazyGit Launcher, because
-- 1) lazygit doesn't get along with powershell
-- 2) j/k terminal map messes up j/k navigation in lazygit
-- These are resetted in lazygit_on_exit_callback
vim.api.nvim_create_user_command("LaunchLazyGit", function()
  if vim.fn.has("win32") == 1 then
    vim.o.shell = "cmd.exe"
  end

  vim.keymap.del("t", "jk")

  vim.cmd("LazyGit")
end, { desc = "Custom lazygit launcher" })

-- Custom Yazi Launcher, because
-- 1) yazi doesn't get along with powershell
-- 2) j/k terminal map messes up j/k navigation in yazi
-- These are resetted in `yazi_closed_successfully` hook
vim.api.nvim_create_user_command("LaunchYazi", function(opts)
  if vim.fn.has("win32") == 1 then
    vim.o.shell = "cmd.exe"
  end

  vim.keymap.del("t", "jk")

  local launchMode = opts.args
  if launchMode == "toggle" then
    vim.cmd("Yazi toggle")
  elseif launchMode == "current" then
    vim.cmd("Yazi")
  end
end, { desc = "Custom Yazi launcher", nargs = 1 })
