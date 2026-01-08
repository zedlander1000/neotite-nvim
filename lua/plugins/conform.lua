return {
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
          timeout_ms = 5000,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters = {
        -- sql_formatter = {
        --   prepend_args = { '-c', vim.fn.expand '~/.config/sql_formatter.json' },
        -- },
        pg_format = {},
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
        sql = { 'pg_format' },
        -- ['*'] = { 'injected' },
        -- python = { "isort", "black" },
      },
    },
  },
}
