-- Set leader here, before everything
vim.g.mapleader = ' ';
vim.g.localmapleader = ' ';
vim.g.have_nerd_font = true
vim.cmd.colorscheme 'slate'
vim.cmd.highlight 'Comment gui=none'

-- Source nvim options
require("options");

-- Source nvim keymaps
require("keymaps");

-- Bootstrap lazy plugin manager
require("lazy-bootstrap");

-- Load plugins
require("lazy-plugins");
