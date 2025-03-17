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
  if vim.fn.has("win32")==1 then
    vim.o.shell = "cmd.exe"
  end

  vim.keymap.del("t", "jk")

  vim.cmd("LazyGit")
end, { desc = "Custom lazygit launcher" })

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}
-- Function to open a terminal in a floating window
local function open_floating_terminal(opts)
  opts = opts or {}
  -- Get the dimensions of the Neovim window
  local width = vim.o.columns
  local height = vim.o.lines

  -- Define the size and position of the floating window
  local float_width = math.floor(width * 0.7) -- 70% of window width
  local float_height = math.floor(height * 0.5) -- 50% of window height
  local float_row = math.floor((height - float_height) / 2) -- Center the window vertically
  local float_col = math.floor((width - float_width) / 2) -- Center the window horizontally

  -- Set up the floating window configuration
  local float_config = {
    relative = "editor", -- Position relative to the editor (main Neovim window)
    width = float_width,
    height = float_height,
    col = float_col,
    row = float_row,
    style = "minimal", -- Use a minimal style (no decorations)
    border = "rounded", -- You can use 'none', 'single', 'double', 'rounded', etc.
  }

  -- Create a terminal buffer
  local term_buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    term_buf = opts.buf
  else
    term_buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer (no name, not listed)
  end

  -- Create the floating window
  local float_win = vim.api.nvim_open_win(term_buf, true, float_config)

  return { buf = term_buf, win = float_win }
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = open_floating_terminal({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
    vim.cmd("normal i")
  else
    vim.api.nvim_win_hide(state.floating.win)
    -- Uncomment next line if you want to be dropped back in insert mode when closing the terminal
    -- vim.api.nvim_feedkeys("i", "n", false)
  end
end

vim.api.nvim_create_user_command(
  "ToggleFloatingTerminal",
  toggle_terminal,
  { desc = "Toggles On/Off the floating terminal" }
)
vim.keymap.set({ "n", "t" }, "tt", "<cmd>ToggleFloatingTerminal<CR>", { desc = "Toggles On/Off the floating terminal" })

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight the text being yanked",
  group = vim.api.nvim_create_augroup("highlight-text", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 250 })
  end,
})

