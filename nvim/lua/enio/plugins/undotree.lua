return {
  "mbbill/undotree",
  version = "*",
  config = function()
    vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
  end,
}
