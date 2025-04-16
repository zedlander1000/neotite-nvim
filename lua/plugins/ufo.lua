local cmd = vim.cmd
local fn = vim.fn
return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  config = function()
    local ufo = require 'ufo'
    ufo.setup {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    }

    local function closeFolds(fb)
      cmd 'silent! %foldclose!'
      local utils = require 'ufo.utils'
      local level = vim.v.count
      local lineCount = fb:lineCount()
      local stack = {}
      local lastLevel = 0
      local lastEndLnum = -1
      local lnum = 1
      while lnum <= lineCount do
        local l = fn.foldlevel(lnum)
        if lastLevel < l or l > 0 and lnum == lastEndLnum + 1 then
          local endLnum = utils.foldClosedEnd(0, lnum)
          table.insert(stack, { endLnum, false })
          if l <= level then
            local cmds = {}
            for i = #stack, 1, -1 do
              local opened = stack[i][2]
              if opened then
                break
              end
              stack[i][2] = true
              table.insert(cmds, lnum .. 'foldopen')
              fb:openFold(lnum)
            end
            if #cmds > 0 then
              cmd(table.concat(cmds, '|'))
              -- A line may contain multiple folds, make sure lnum is opened.
              while lnum == utils.foldClosed(0, lnum) do
                cmd(lnum .. 'foldopen')
              end
            end
          else
            --TODO
            -- (#184)
            --`%foldclose!` doesn't close all folds for window
            --endLnum may return -1, look like upstream issue.
            if lnum < endLnum then
              lnum = endLnum
            end
          end
        end
        lastLevel = l
        lnum = lnum + 1
        while #stack > 0 do
          local endLnum = stack[#stack][1]
          if lnum <= endLnum then
            break
          end
          table.remove(stack)
          lastEndLnum = math.max(lastEndLnum, endLnum)
        end
      end
    end

    local function applyFoldsToSelection()
      require 'async'(function()
        vim.api.nvim_input '<Esc>'

        local bufnr = vim.api.nvim_get_current_buf()
        local fold = require 'ufo.fold'
        local fold_buffer = fold.get(bufnr)

        ufo.attach(bufnr)

        local selectionStart = vim.fn.getpos('v')[2] - 1
        local selectionEnd = vim.fn.getpos('.')[2] - 1
        selectionStart, selectionEnd = table.unpack { math.min(selectionStart, selectionEnd), math.max(selectionStart, selectionEnd) }

        local ranges = await(ufo.getFolds(bufnr, fold_buffer.selectedProvider))
        if not vim.tbl_isempty(ranges) then
          for _, range in ipairs(ranges) do
            if selectionStart <= range.startLine and selectionEnd >= range.endLine then
              fold_buffer:closeFold(range.startLine + 1, range.endLine + 1)
            end
          end
          for _, fl in pairs(fold_buffer.foldedLines) do
          end
          -- closeFolds(fold_buffer)
        end
      end)
    end

    vim.keymap.set({ 'n', 'v' }, 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })
    vim.keymap.set({ 'n', 'v' }, 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
    -- vim.keymap.set('v', 'za', applyFoldsToSelection, { desc = 'Toggle selected folds' })
  end,
}
