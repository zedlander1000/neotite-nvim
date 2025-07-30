vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.undofile = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 999

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

vim.o.foldcolumn = 'auto:9'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep:│,foldclose:'

vim.opt.wrap = false

vim.opt.spelllang = { 'en_us' }
vim.opt.spell = true
vim.opt.spelloptions = 'camel'
vim.opt.spellcapcheck = ''

vim.opt.conceallevel = 1
