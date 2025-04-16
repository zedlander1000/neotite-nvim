return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ['<leader>e'] = 'actions.close',
        },
        win_options = {
          signcolumn = 'number',
        },
      }
      vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Open Oil' })
    end,
  },
}
