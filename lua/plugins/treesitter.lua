return {
  { -- Highlight, edit, and navigate code (nvim-treesitter `main` rewrite)
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    -- The rewrite is lazy-friendly; load on file open so highlight attaches
    -- to the first buffer too.
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'TSUpdate', 'TSInstall', 'TSUninstall', 'TSUpdateSync' },
    config = function()
      local ts = require 'nvim-treesitter'

      -- Parsers we want available. (Neovim 0.12 already bundles
      -- c, lua, markdown, markdown_inline, query, vim, vimdoc — listing them
      -- again is harmless; install() skips what's present.)
      local wanted = {
        'bash',
        'c',
        'css',
        'diff',
        'eex',
        'elixir',
        'erlang',
        'heex',
        'html',
        'javascript',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'scss',
        'sql',
        'vim',
        'vimdoc',
      }

      -- Install only what's missing (avoids re-fetch on every startup).
      local installed = require('nvim-treesitter.config').get_installed 'parsers'
      local have = {}
      for _, p in ipairs(installed) do
        have[p] = true
      end
      local missing = {}
      for _, p in ipairs(wanted) do
        if not have[p] then
          missing[#missing + 1] = p
        end
      end
      if #missing > 0 then
        ts.install(missing) -- async; returns immediately
      end

      -- Enable highlighting + treesitter indent per buffer.
      local group = vim.api.nvim_create_augroup('user_treesitter', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        callback = function(args)
          local ft = args.match
          local lang = vim.treesitter.language.get_lang(ft) or ft

          -- Only proceed if a parser is actually available, otherwise
          -- vim.treesitter.start() throws.
          if not vim.treesitter.language.add(lang) then
            return
          end

          -- Highlighting (replaces highlight = { enable = true }).
          pcall(vim.treesitter.start, args.buf, lang)

          -- Indentation (replaces indent = { enable = true }).
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
