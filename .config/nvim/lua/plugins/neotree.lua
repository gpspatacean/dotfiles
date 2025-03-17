return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "\\", ":Neotree reveal<CR>", { desc = "Neotree reveal" } },
      -- TODO: chose other keymap; check for toggle/focus combos
      -- { 'b', ':Neotree toggle show buffers<CR>', { desc = 'Neotree buffers' } },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ["\\"] = "close_window",
          },
        },
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          never_show = { ".git" },
        },
      },
    },
  },
}
