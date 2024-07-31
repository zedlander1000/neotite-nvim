return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
        theme = 'tokyonight',
      },
      sections = {
        lualine_c = { { 'filename', path = 1 } },
      },
      tabline = {
        lualine_a = { 'buffers' },
        lualine_z = { 'tabs' },
      },
    },
  },
}
