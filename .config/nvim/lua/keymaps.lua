vim.keymap.set("i", "jk", "<Esc>", { desc = 'Exit insert mode with "jk"' })
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = 'Exit terminal mode with "jk"' })

-- Splits management
vim.keymap.set("n", "<leader>s|", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>s-", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits size equal" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Buffers
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<Tab><Tab>", "<cmd>ls<CR>", { desc = "List Buffers" })
vim.keymap.set("n", "<A-q>", "<cmd>bd<CR>", { desc = "Delete Current Buffer" })

-- Tabs management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Move to next tab" }) -- 'gt'
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Move to previous tab" }) -- 'gT'
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current file in new tab" })

-- Lua shortcuts
vim.keymap.set("n", "<leader>ls", "<cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("n", "<leader>lx", ":.lua<CR>", { desc = "Run current line with lua" })
vim.keymap.set("v", "<leader>lx", ":lua<CR>", { desc = "Run current lines with lua" })

-- Move lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current line(s) down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move current line(s) up" })

-- Random
vim.keymap.set("n", "q", "<nop>", { desc = "Disable macro recording" })
