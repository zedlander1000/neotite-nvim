return {
  'andythigpen/nvim-coverage',
  version = '*',
  config = function()
    local coverage = require('coverage')
    coverage.setup({ auto_reload = true })
  end
}
