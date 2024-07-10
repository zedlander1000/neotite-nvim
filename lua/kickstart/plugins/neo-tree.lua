-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
  init = function()
    vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })
    require('neo-tree').setup {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
      window = {
        mappings = {
          ['h'] = {
            function(state)
              local node = state.tree:get_node()
              if node.type == 'directory' and node:is_expanded() then
                require('neo-tree.sources.filesystem').toggle_directory(state, node)
              else
                require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
              end
            end,
            desc = 'Collaps Directory',
          },
          ['l'] = {
            function(state)
              local node = state.tree:get_node()
              if node.type == 'directory' then
                if not node:is_expanded() then
                  require('neo-tree.sources.filesystem').toggle_directory(state, node)
                elseif node:has_children() then
                  require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
                end
              end
            end,
            desc = 'Expand Directory',
          },
          -- ['N'] = {
          --   function()
          --     vim.api.nvim_command 'bN'
          --   end,
          --   desc = 'Unfocus Neotree',
          -- },
          -- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
          -- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
          -- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
          -- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
        },
      },
    }
    local manager = require 'neo-tree.sources.manager'
    local renderer = require 'neo-tree.ui.renderer'

    for _, source in ipairs(require('neo-tree').config.sources) do
      vim.keymap.set(
        { 'n', 'v' },
        '<leader>e' .. source:sub(0, 1),
        '<CMD>Neotree toggle ' .. source .. '<CR>',
        { desc = 'Toggle Neotree source (' .. source .. ')' }
      )
    end

    vim.keymap.set({ 'n', 'v' }, '<leader>e', function()
      for _, source in ipairs(require('neo-tree').config.sources) do
        local state = manager.get_state(source)
        local opened = renderer.window_exists(state)

        if opened and state['bufnr'] ~= vim.api.nvim_get_current_buf() then
          require('neo-tree.command').execute { action = 'focus' }
          return
        elseif opened then
          require('neo-tree.command').execute { action = 'close' }
          return
        end
      end
      require('neo-tree.command').execute { toggle = true }
    end, { desc = 'Focus or Close Neotree' })
    vim.keymap.set({ 'n', 'v' }, '<leader>e?', function()
      vim.api.nvim_command 'WhichKey <leader>e'
    end)
  end,
}
