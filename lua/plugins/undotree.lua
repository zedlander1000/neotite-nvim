return {
  {
    'mbbill/undotree',
    config = function()
      if vim.fn.has 'persistent_undo' then
        local target = vim.fn.expand '~/.nvim-undo'
        if not vim.fn.isdirectory(target) then
          vim.fn.mkdir(target, 'p', '0700')
        end
        vim.o.undodir = target
      end
      vim.keymap.set('n', '<leader>u', function()
        vim.cmd.UndotreeToggle()
        vim.cmd.UndotreeFocus()
      end, { desc = 'Undo Tree' })
    end,
  },
}
