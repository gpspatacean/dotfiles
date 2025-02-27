vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with \"jk\"" });
vim.keymap.set("n", "<leader>nh", ":nohl<CR>",  { desc = "Clear search highlights" });

-- Splits management
vim.keymap.set("n", "<leader>s|", "<C-w>v", { desc = "Split window vertically"})
vim.keymap.set("n", "<leader>s-", "<C-w>s", { desc = "Split window horizontally"})
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits size equal"})
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split"})

-- Buffers
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<Tab><Tab>", "<cmd>ls<CR>", { desc = "List Buffers" })

-- Tabs management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab"})
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab"})
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Move to next tab"}) -- 'gt'
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Move to previous tab"}) -- 'gT'
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current file in new tab"})

-- Lua shortcuts
vim.keymap.set("n", "<leader>ls", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>lx", ":.lua<CR>")
vim.keymap.set("v", "<leader>lx", ":lua<CR>")

