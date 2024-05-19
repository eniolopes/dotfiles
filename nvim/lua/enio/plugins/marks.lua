return {
  "chentoast/marks.nvim",
  version = "*",
  config = function()
    require("marks").setup({
      cyclic = true,
      mappings = {
        toggle = "<leader>m",
        next = "<leader><leader>",
        prev = "<leader>.",
        delete = "<leader>md",
        delete_buf = "<leader>mD",
      },
    })
  end,
}
