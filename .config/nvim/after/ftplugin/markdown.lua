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

-- Floating wrap preview for current line (<leader>lw)
local function toggle_line_wrap_float()
  local line = vim.api.nvim_get_current_line()
  if line == "" then return end

  local win_width = math.min(100, math.max(40, vim.api.nvim_win_get_width(0) - 10))
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { line })
  vim.bo[buf].filetype = "markdown"

  local line_len = #line
  local height = math.max(3, math.ceil(line_len / win_width) + 1)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'cursor',
    row = 1,
    col = 0,
    width = win_width,
    height = height,
    style = 'minimal',
    border = 'rounded',
    title = ' Line Wrap Preview ',
    title_pos = 'center',
  })

  vim.wo[win].wrap = true
  vim.wo[win].linebreak = true

  -- Close on <Esc> or q
  vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', { buffer = buf })
  vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = buf })
end

vim.keymap.set('n', '<leader>lw', toggle_line_wrap_float, { buffer = true, desc = 'Line Wrap float preview' })
vim.keymap.set('n', '<leader>tw', function()
  vim.wo.wrap = not vim.wo.wrap
  vim.wo.linebreak = vim.wo.wrap
end, { buffer = true, desc = 'Toggle Line Wrap for buffer' })

