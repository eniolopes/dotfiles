return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  keys = {
    { "<leader>tt", "<cmd>TroubleToggle<CR>", desc = "Open/close trouble list" },
    { "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
    { "<leader>td", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Open trouble document diagnostics" },
  },
}
