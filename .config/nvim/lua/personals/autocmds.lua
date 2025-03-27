-- Various auto commands

-- Do not show line numbers in the terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight the text being yanked",
  group = vim.api.nvim_create_augroup("highlight-text", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 250 })
  end,
})
