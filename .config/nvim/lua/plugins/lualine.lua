-- Lualine plugin - custom status line
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "powerline" },
        sections = {
          lualine_c = { { "filename", path = 3 } },
        },
      })
    end,
  },
}
