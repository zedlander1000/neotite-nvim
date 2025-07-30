vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1 }
end, { desc = 'Go to previous [D]iagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1 }
end, { desc = 'Go to next [D]iagnostic message' })

vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
-- vim.keymap.set('n', '<C-A-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-A-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-A-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-A-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<A-l>', '<CMD>bn<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<A-h>', '<CMD>bN<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<F28>', '<CMD>bd<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<F40>', '<CMD>%bd<CR>', { desc = 'Close all buffers' })
vim.keymap.set('n', '<F16>', '<CMD>bd!<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<M-C-S-F4>', '<CMD>%bd!<CR>', { desc = 'Close all buffers' })
-- vim.keymap.set('n', '<leader>to', function()
--   local otter = require 'otter'
--   vim.g.otter_active = false
--
--   if not vim.g.otter_active then
--     otter.activate()
--   else
--     otter.deactivate()
--   end
-- end)

vim.keymap.set('n', '<leader>;', function()
  local neogit = require 'neogit'
  local instance = neogit.status.instance()
  if instance and instance:is_open() then
    neogit.close()
  else
    neogit.open()
  end
end)

vim.keymap.set('i', '<C-R>', '<Esc>R', { desc = 'Enter replace mode ' })
-- vim.keymap.set({ 'n', 'i', 'v' }, '<C-z>', 'ZZ', { noremap = true })
--
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
