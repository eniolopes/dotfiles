-- Options
local opt = vim.opt
opt.number = true
opt.tabstop = 2                     -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2                  -- 2 spaces for indent width
opt.expandtab = true                -- expand tab to spaces
opt.autoindent = true               -- copy indent from current line when starting new one
opt.wrap = false                    -- disable line wrapping
opt.ignorecase = true               -- ignore case when searching
opt.smartcase = true                -- if you include mixed case in your search, assumes you want case-sensitive
opt.cursorline = true               -- highlight the current cursor line
opt.termguicolors = true
opt.signcolumn = "yes"              -- show sign column so that text doesn't shift
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
opt.splitright = true               -- split vertical window to the right
opt.splitbelow = true               -- split horizontal window to the bottom
opt.undofile = true                 -- save undo history after file is closed

-- Key map definitions
local keymap = vim.keymap
vim.g.mapleader = ","
keymap.set("i", "jk", "<ESC>", { desc = "Exit instert mode with jk" })
keymap.set("n", "<CR>", ":nohl<CR>", { desc = "Clear search highlights" })
-- Buffers
keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Go to next tab" })
keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>c", ":bdelete<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>q", function()
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_buffer_name = vim.api.nvim_buf_get_name(current_buffer)
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    local buffer_name = vim.api.nvim_buf_get_name(buffer)
    if buffer_name ~= current_buffer_name then
      vim.api.nvim_buf_delete(buffer, { force = true })
    end
  end
end, { desc = "Close all other buffers" })
--LSP
keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Jump to definition" })
-- Key mappings for navigating and viewing diagnostics
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show diagnostics for current line" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set('n', '<leader>nf', function()
  local mf = require('mini.files')
  mf.open(vim.api.nvim_buf_get_name(0))
  mf.reveal_cwd()
end)

-- Configure how diagnostics are displayed
vim.diagnostic.config({
  virtual_text = { prefix = '●', source = "always" },
  signs = true,
  float = { source = "always" },
  severity_sort = true,
})

--GIT
vim.keymap.set("n", "<leader>gy", function()
  require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
end)

--GP
vim.keymap.set("n", "<leader>gn", ":GpChatNew vsplit<cr>", { desc = "Create new GP chat" })
vim.keymap.set("n", "<leader>gp", ":GpChatToggle vsplit<cr>", { desc = "Toggle to latest GP chat" })
vim.keymap.set("v", "<leader>gp", ":GpChatPaste vsplit<cr>", { desc = "Paste selection in latest GP chat" })

-- Setup lazy.nvim and plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
function Load_mini_plugin(name, setup_args, config)
  setup_args = setup_args or {}
  config = config or function() end
  return {
    "echasnovski/mini." .. name,
    version = "*",
    config = function()
      require("mini." .. name).setup(setup_args)
      config()
    end
  }
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true },
  spec = {

    {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
        require("catppuccin").setup({
          flavour = "mocha", -- latte, frappe, macchiato, mocha
        })
        vim.cmd.colorscheme "catppuccin"
      end
    },

    {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      },
    },

    {
      "mason-org/mason.nvim",
      config = function()
        require("mason").setup()
      end
    },

    {
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }
              }
            }
          }
        })
        lspconfig.ts_ls.setup({})
        lspconfig.rust_analyzer.setup({
          cmd = { "/opt/homebrew/bin/rust-analyzer" },
          on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end,
          settings = {
            ["rust-analyzer"] = {
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
              procMacro = {
                enable = true
              },
            }
          }
        })
      end
    },

    {
      "mason-org/mason-lspconfig.nvim",
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
      config = function()
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
          ensure_installed = {
            "lua_ls",
            "gopls",
            "ts_ls",
          }
        })
      end
    },

    -- GIT
    { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup({ current_line_blame = true }) end },

    Load_mini_plugin("tabline"),
    Load_mini_plugin("statusline"),
    Load_mini_plugin("icons"),
    Load_mini_plugin("notify"),
    Load_mini_plugin("trailspace"),
    Load_mini_plugin("surround"),
    Load_mini_plugin("pairs"),
    Load_mini_plugin("cursorword"),
    Load_mini_plugin("completion"),
    Load_mini_plugin("clue", {
      triggers = {
        { mode = "n", keys = "<Leader>" },
        { mode = "n", keys = "s" }, -- mini.surround
        { mode = "x", keys = "s" }, -- mini.surround
        { mode = "x", keys = "<Leader>" },
        { mode = "n", keys = "g" }, -- Most LSP keymaps
      }
    }),
    Load_mini_plugin("files", { preview = true }, function()
      keymap.set("n", "<leader><Tab>", ":lua MiniFiles.open()<CR>", { desc = "Open MiniFiles" })
    end),

    Load_mini_plugin("pick", {}, function()
      keymap.set("n", "<leader>ff", ":lua MiniPick.builtin.files()<CR>", { desc = "Open MiniPicker with files" })
      keymap.set("n", "<leader>fg", ":lua MiniPick.builtin.files({ tool = \"git\"})<CR>",
        { desc = "Open MiniPicker with git tool" })
      keymap.set("n", "<leader>fs", ":lua MiniPick.builtin.grep_live()<CR>", { desc = "Open MiniPicker with grep" })
      keymap.set("n", "<leader>fb", ":lua MiniPick.builtin.buffers()<CR>", { desc = "Open MiniPicker with open buffers" })
      keymap.set("n", "<leader>fh", ":lua MiniPick.builtin.resume()<CR>", { desc = "Open last MiniPicker search" })
      keymap.set("n", "<leader>fc", ":lua MiniPick.builtin.grep({ pattern = vim.fn.expand(\"<cword>\")})<CR>",
        { desc = "Find current word" })
    end),

  },
})
