-- Lualine plugin - custom status line
local function hello()
  return "Hello!"
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "powerline" },
        sections = {
          lualine_c = { "filename", "buffers" },
        },
      })
    end,
  },
}
