return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    delay = 200,
    filetypes_denylist = {
      "mason",
      "harpoon",
      "neo-tree",
      "DressingInput",
      "NeogitCommitMessage",
      "qf",
      "dirvish",
      "fugitive",
      "alpha",
      "NvimTree",
      "lazy",
      "Trouble",
      "netrw",
      "lir",
      "DiffviewFiles",
      "Outline",
      "Jaq",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "TelescopePrompt",
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}
