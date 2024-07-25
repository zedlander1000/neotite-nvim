return {
  {
    'elixir-tools/elixir-tools.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('elixir').setup {
        nextls = { enable = true },
        elixirls = { enable = true },
        projectionist = { enable = true },
      }
    end,
  },
}
