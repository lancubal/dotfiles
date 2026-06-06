-- Bold
vim.keymap.set('i', '<C-b>', '****<Left><Left>', { buffer = true, desc = "Bold" })
vim.keymap.set('v', '<C-b>', 'c**<C-r>"**<Esc>', { buffer = true, desc = "Bold" })

-- Italic
vim.keymap.set('i', '<C-i>', '**<Left>', { buffer = true, desc = "Italic" })
vim.keymap.set('v', '<C-i>', 'c*<C-r>"*<Esc>', { buffer = true, desc = "Italic" })

-- Auto spell check on save
vim.api.nvim_create_autocmd('BufWritePost', {
  buffer = 0,
  callback = function()
    SpellCheckToQuickfix()
  end,
})

