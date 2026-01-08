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
  { 'dbmrq/vim-dialect' },
}
