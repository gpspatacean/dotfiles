-- Show line numbers
vim.opt.number = true
-- Show line numbers around current line as relative numbers to the current line 
vim.opt.relativenumber = true
-- Highlight found occurences when searching
vim.opt.hlsearch = true
-- Use incremental search - show matches as you type
vim.opt.incsearch = true
-- By default, ignore case when searching
vim.opt.ignorecase = true

-- Always have at least 8 rows shown at the top or the bottom of the screen
vim.opt.scrolloff=8

-- Configure where new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable changed and unsaved buffers to be switched from
vim.opt.hidden = true

-- Show the current line 
vim.opt.cursorline = true

-- Disable VIM mode feedback in command line bar
vim.opt.showmode = false



-- vim.opt.list = true
-- vim.opt.listchars = { tab = '>> ', trail = '-', nbsp = "_" }
