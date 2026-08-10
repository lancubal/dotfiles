-- Bold
vim.keymap.set('i', '<C-b>', '****<Left><Left>', { buffer = true, desc = "Bold" })
vim.keymap.set('v', '<C-b>', 'c**<C-r>"**<Esc>', { buffer = true, desc = "Bold" })

-- Italic
vim.keymap.set('i', '<C-i>', '**<Left>', { buffer = true, desc = "Italic" })
vim.keymap.set('v', '<C-i>', 'c*<C-r>"*<Esc>', { buffer = true, desc = "Italic" })

-- Auto spell check on save (quiet mode)
vim.api.nvim_create_autocmd('BufWritePost', {
  buffer = 0,
  callback = function()
    SpellCheckToQuickfix({ quiet = true })
  end,
})

-- Dynamic wrap: Enable wrap only when the current line exceeds window width
local wrap_group = vim.api.nvim_create_augroup('MarkdownDynamicWrap', { clear = true })
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufEnter' }, {
  buffer = 0,
  group = wrap_group,
  callback = function()
    local line_len = #vim.api.nvim_get_current_line()
    local win_width = vim.api.nvim_win_get_width(0)
    if line_len > win_width then
      vim.wo.wrap = true
      vim.wo.linebreak = true
    else
      vim.wo.wrap = false
    end
  end,
})

