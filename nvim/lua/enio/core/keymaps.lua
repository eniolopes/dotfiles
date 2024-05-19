vim.g.mapleader = ","
local keymap = vim.keymap
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" }) -- use jk to exit insert mode

keymap.set("n", "<CR>", ":nohl<CR>", { desc = "Clear search highlights" }) -- clear search highlights

-- Buffers
keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Go to next tab" })
keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>c", ":bdelete<CR>", { desc = "Close current tab" })

-- Uses :m to move visual selection up or down
keymap.set("x", "K", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap.set("x", "J", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Closes all open buffers except the current one
keymap.set("n", "<leader>q", function ()
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_buffer_name = vim.api.nvim_buf_get_name(current_buffer)
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    local buffer_name = vim.api.nvim_buf_get_name(buffer)
    if buffer_name ~= current_buffer_name then
      vim.api.nvim_buf_delete(buffer, { force = true })
    end
  end
end, { desc = "Close all other buffers" })
