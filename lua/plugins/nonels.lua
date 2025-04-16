return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      debug = true,
      diagnostics_format = '#{m} (#{s})',
      sources = {
        null_ls.builtins.diagnostics.credo.with {
          method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          extra_args = { '--strict', '-i', 'WrongTestFileExtension' },
        },
        null_ls.builtins.formatting.prettier,
      },
    }
  end,
}
