return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = "catppuccin",
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          }
        },
      },
    })
  end,
}
