require 'config.options'
require 'config.keymaps'
require 'config.autocmd'
require 'config.lazy'
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
-- local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
-- if not vim.loop.fs_stat(lazypath) then
--   local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
--   vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
-- end ---@diagnostic disable-next-line: undefined-field
-- vim.opt.rtp:prepend(lazypath)
--
-- require('lazy').setup 'plugins'

-- local get_css_sugessions = function(cssfile)
--   local a = require('plenary.path'):new(cssfile)
--   vim.notify(a:read():gsub('\\', ''))
-- end
--
-- vim.keymap.set('n', '<leader>l', function()
--   get_css_sugessions 'app.css'
-- end)
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
