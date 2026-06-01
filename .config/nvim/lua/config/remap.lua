-- Move visually selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Moves whole line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Moves whole line up' })

-- Move lines (Alt + j/k or Alt + Arrows)
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down' })
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Duplicate lines (Alt + Shift + j/k or Alt + Shift + Arrows)
vim.keymap.set('n', '<A-S-j>', 'yyp', { desc = 'Duplicate line down' })
vim.keymap.set('n', '<A-S-k>', 'yyP', { desc = 'Duplicate line up' })
vim.keymap.set('i', '<A-S-j>', '<Esc>yypgi', { desc = 'Duplicate line down' })
vim.keymap.set('i', '<A-S-k>', '<Esc>yyPgi', { desc = 'Duplicate line up' })
vim.keymap.set('v', '<A-S-j>', "y'>pgv", { desc = 'Duplicate selection down' })
vim.keymap.set('v', '<A-S-k>', "y'<Pgv", { desc = 'Duplicate selection up' })

-- Support for Arrow keys as well
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==')
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<A-S-Down>', 'yyp')
vim.keymap.set('n', '<A-S-Up>', 'yyP')

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Show diagnostics [Q]uickfix list' })
vim.keymap.set('n', '<leader>d', function()
  vim.diagnostic.open_float(nil, { focusable = true })
end, { desc = 'Show line [D]iagnostics' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

-- LSP formatting
vim.keymap.set('n', '<leader><Space>', function()
  vim.lsp.buf.format { async = true }
end, { desc = 'Format buffer' })

vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Smart Rename' })

--Buffer navigation
vim.keymap.set('n', '<Tab>', ':bn<CR>', { desc = 'Switches to next buffer' })
vim.keymap.set('n', '<S-Tab>', ':bp<CR>', { desc = 'Switches to previous buffer' })

-- Split window navigation: CTRL+<hjkl>
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move left."<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move right"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move up"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move down"<CR>')

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>h', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Make split windows equal size' })
vim.keymap.set('n', '<leader>wx', '<cmd>close<CR>', { desc = 'Close current split' })

-- Tab management
vim.keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab' })
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' })
vim.keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' })
vim.keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab' })

-- Jump list navigation (Go back/forward)
vim.keymap.set('n', '<leader>bb', '<C-o>', { desc = 'Jump back to previous location' })
vim.keymap.set('n', '<leader>bf', '<C-i>', { desc = 'Jump forward to next location' })

-- File explorer
vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })
vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'Open Oil explorer' })

-- Terminal
vim.keymap.set('n', '<leader>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd('J')
  vim.api.nvim_win_set_height(0, 15)
end, { desc = 'Terminal split bottom' })

-- Terminal mode escape
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Add empty lines
vim.keymap.set('n', '<CR>', 'm`o<Esc>``', { desc = 'Add empty line below' })
vim.keymap.set('n', '<S-CR>', 'm`O<Esc>``', { desc = 'Add empty line above' })

-- Misc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clears search highlight' })
vim.keymap.set(
  'n',
  '<leader>s',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Find and replace word under cursor' }
)
