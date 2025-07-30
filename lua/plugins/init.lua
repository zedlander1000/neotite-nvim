return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        'lazy.nvim',
        'luvit-meta/library',
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        'LazyVim',
        { path = 'LazyVim', words = { 'LazyVim' } },
        { path = 'wezterm-types', mods = { 'wezterm' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup { triggers = {
        { '<auto>', mode = 'nixsotc' },
        { '<C-w>', mode = 'n' },
      } }

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>c_', hidden = true },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>d_', hidden = true },
        { '<leader>h', group = 'Git [H]unk' },
        { '<leader>h_', hidden = true },
        { '<leader>r', group = '[R]ename' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = '[S]earch' },
        { '<leader>s_', hidden = true },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>t_', hidden = true },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>w_', hidden = true },
        { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
        {
          '<C-w><space>',
          function()
            require('which-key').show { keys = '<C-w>', loop = true }
          end,
          desc = 'Window Hydra Mode',
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>ff',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 1000,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters = {
        sql_formatter = {
          prepend_args = { '-c', vim.fn.expand '~/.config/sql_formatter.json' },
        },
        prettier = { prepend_args = { '--prose-wrap', 'always' } },
        mix = { prepend_args = { 'format' } },
        -- sqlfluff = {
        --   prepend_args = { '--config', vim.fn.expand '~/.config/.sqruff' },
        -- },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        markdown = { 'prettier' },
        elixir = { 'mix' },
        -- sql = { 'pg_format' },
        -- ['*'] = { 'injected' },
        -- python = { "isort", "black" },
      },
    },
  },

  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { 'dbmrq/vim-dialect' },
}
