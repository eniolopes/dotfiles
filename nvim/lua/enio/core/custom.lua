-- Creates a stack to keep track of position. Each position is a filename and line number
-- The functions to manipulate the stack are:
-- Add a position, cycle through the positions, delete current position
local function add(elephant)
  local filename = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  local stack = elephant.stack
  table.insert(stack, {filename=filename, line=line, sign_id=#stack})
  vim.g.elephant = { stack=stack, current=#stack }
  vim.cmd("sign place " .. #stack .. " line=" .. line .. " name=Elephant file=" .. filename)
end

local function cycle(elephant)
  local current = elephant.current
  local stack_size = #elephant.stack
  local current_filename = vim.fn.expand("%:p")
  if stack_size == 0 then
    return
  end
  if current + 1 > stack_size then
    vim.g.elephant = { current=1, stack=elephant.stack }
  else
    vim.g.elephant = { current=current + 1, stack=elephant.stack }
  end
  if current_filename ~= elephant.stack[elephant.current].filename then
    vim.cmd("e " .. elephant.stack[elephant.current].filename)
  end
  vim.cmd(":" .. elephant.stack[elephant.current].line)
end

local function delete(elephant)
  local current_filename = vim.fn.expand("%:p")
  local current_line = vim.fn.line(".")
  local current = elephant.current
  local stack = elephant.stack
  for i, position in ipairs(stack) do
    print(i, position.filename, position.line, current_filename, current_line)
    if position.filename == current_filename and position.line == current_line then
      print("removing position at index", i)
      table.remove(stack, i)
      vim.cmd("sign unplace " .. position.sign_id .. " file=" .. position.filename)
      vim.g.elephant = {stack=stack, current=current}
      break
    end
  end

  local stack_size = #stack
  if current > stack_size then
    vim.g.elephant = {stack=stack, current=stack_size}
  end
end

vim.g.elephant = {stack={}, current=0}
vim.cmd(":sign define Elephant text=🐘")
vim.keymap.set("n", "<leader>pa", function()
  add(vim.g.elephant)
end, { desc="Add position to stack" })

vim.keymap.set("n", "<leader>.", function()
  cycle(vim.g.elephant)
end, { desc="Cycle through positions" })

vim.keymap.set("n", "<leader>pd", function ()
  delete(vim.g.elephant)
end, { desc="Delete current position" })

vim.keymap.set("n", "<leader>pc", function ()
  vim.g.elephant = {stack={}, current=0}
end, { desc="Clear stack" })

vim.keymap.set("n", "<leader>ps", function ()
  vim.print(vim.inspect(vim.g.elephant.stack))
  vim.cmd(":messages")
end, { desc="List stack" })
