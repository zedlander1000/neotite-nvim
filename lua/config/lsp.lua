vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('grn', vim.lsp.buf.rename, '[R]e[n]ame.')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction.', { 'n', 'x' })
    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences.')
    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementations.')
    map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinitions.')
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclarations.')
    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definitions.')

    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap.
    map('<C-q>', vim.lsp.buf.hover, 'Hover Documentation')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- The following auto command is used to enable inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})
vim.api.nvim_create_user_command('LspLog', function(opts)
  if opts.args == 'clear' then
    vim.fn.writefile({}, vim.lsp.log.get_filename())
  else
    vim.cmd.edit(vim.lsp.log.get_filename())
  end
end, { nargs = '?', complete = function() return { 'clear' } end })
vim.api.nvim_create_user_command('LspLevel', function(opts)
  local levels = { 'TRACE', 'DEBUG', 'INFO', 'WARN', 'ERROR', 'OFF' }
  local arg = opts.args ~= '' and opts.args or nil
  if arg == nil then
    vim.notify('LSP log level: ' .. vim.lsp.log.get_level(), vim.log.levels.INFO)
  elseif arg:upper() == 'RESET' then
    vim.lsp.log.set_level('WARN')
    vim.notify('LSP log level reset to WARN', vim.log.levels.INFO)
  else
    local upper = arg:upper()
    if not vim.tbl_contains(levels, upper) then
      vim.notify('Invalid level: ' .. arg .. '. Valid: ' .. table.concat(levels, ', ') .. ', reset', vim.log.levels.ERROR)
      return
    end
    vim.lsp.log.set_level(upper)
    vim.notify('LSP log level set to ' .. upper, vim.log.levels.INFO)
  end
end, {
  nargs = '?',
  complete = function()
    return { 'TRACE', 'DEBUG', 'INFO', 'WARN', 'ERROR', 'OFF', 'reset' }
  end,
})

-- Change diagnostic symbols in the sign column (gutter)
if vim.g.have_nerd_font then
  local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
  local diagnostic_signs = {}
  for type, icon in pairs(signs) do
    diagnostic_signs[vim.diagnostic.severity[type]] = icon
  end
  vim.diagnostic.config { signs = { text = diagnostic_signs } }
end
