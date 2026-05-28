return {
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          ui = {
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        },
      },
      { 'neovim/nvim-lspconfig' },
      { 'j-hui/fidget.nvim', opts = {} },
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
          ensure_installed = {
            -- LSPs
            'expert',
            -- 'elixirls',
            'tailwindcss',
            'cssls',
            'postgres_lsp',
            'lua_ls',
            'clangd',
            'pyright',
            'ts_ls',
            -- Formatters
            'prettier',
            'stylua',
            'shfmt',
            -- Linters
          },
        },
      },
    },
    opts = {},
  },
}
