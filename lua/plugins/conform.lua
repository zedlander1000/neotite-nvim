return {
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>ff',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = 'n',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 5000,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      log_level = vim.log.levels.DEBUG,
      formatters = {
        prettier = { prepend_args = { '--find-config-path' } },
        pg_format = {},
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        markdown = { 'prettier' },
        sql = { 'pg_format' },
      },
    },
  },
}
