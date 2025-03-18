-- Show line numbers
vim.opt.number = true
-- Show line numbers around current line as relative numbers to the current line
vim.opt.relativenumber = true

-- Search settings
vim.opt.hlsearch = true -- Highlight found occurences when searching
vim.opt.incsearch = true -- Use incremental search - show matches as you type
vim.opt.ignorecase = true -- By default, ignore case when searching...
vim.opt.smartcase = true -- ...but revert to case sensitiveness when search pattern is mixed case

-- Always have at least 8 rows shown at the top or the bottom of the screen
vim.opt.scrolloff = 8

-- Configure where new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable changed and unsaved buffers to be switched from
vim.opt.hidden = true

-- Show the current line
vim.opt.cursorline = true

-- Disable VIM mode feedback in command line bar
vim.opt.showmode = false

-- Do not wrap lines longer than screen width
vim.opt.wrap = false

-- Do not use swapfile
vim.opt.swapfile = false

-- Tabs & identation
vim.opt.autoindent = true -- Copy indentation from current line when starting a new one

vim.opt.list = true
-- vim.opt.listchars = { tab = "\\u2192 \\u2192", trail = "\\u2297", nbsp = "_", eol = "\\u21b2" }
vim.opt.listchars = { tab = "-->", trail = "\\u2297", nbsp = "_", eol = "\\u21b2" }

-- Activate timeout and set it to half sec
vim.opt.timeout = true
vim.opt.timeoutlen = 500

if vim.fn.has("win32") == 1 then
  vim.o.shell = "powershell.exe"
end
