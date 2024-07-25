-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- vim.keymap.set('n', '<leader>`', '<CMD>! wezterm start --cwd ${PWD}<CR>', { silent = true, desc = 'Start New Wezterm' })

vim.opt.wrap = false

return {
  -- {
  --   'debugloop/telescope-undo.nvim',
  --   dependencies = {
  --     'nvim-telescope/telescope.nvim',
  --     dependencies = { 'nvim-lua/plenary.nvim' },
  --   },
  --   keys = {
  --     {
  --       '<leader>u',
  --       '<cmd>telescope undo<cr>',
  --       desc = 'Search Undo History',
  --     },
  --   },
  --   opts = {
  --     extensions = {
  --       undo = {},
  --     },
  --   },
  --   config = function(_, opts)
  --     require('telescope').setup(opts)
  --     require('telescope').load_extension 'undo'
  --   end,
  -- },
}
