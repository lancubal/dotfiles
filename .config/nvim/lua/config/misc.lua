-- THIS FILE IS LOADED BEFORE THE PLUGINS

-- No automatic comment insertion
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Yanking highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlights text when yanking',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Rounded floating windows
vim.diagnostic.config({
  float = {
    border = 'rounded',
    max_width = 80,
  },
})

-- Close all buffers except the current one
function CloseAllBuffersExceptCurrent()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    -- Skip the current buffer
    if buf ~= current_buf then
      -- Check if the buffer is loaded and not modified
      if vim.api.nvim_buf_is_loaded(buf) and not vim.bo.modified then
        -- Delete the buffer
        vim.api.nvim_buf_delete(buf, { force = false })
      end
    end
  end

  local has_notify, notify = pcall(require, 'notify')
  if has_notify then
    vim.notify = notify
  end
  vim.notify('Closed all buffers except current', vim.log.levels.INFO)
end

vim.api.nvim_create_user_command('BufOnly', function()
  CloseAllBuffersExceptCurrent()
end, { desc = 'Close all buffers except current' })

vim.keymap.set('n', '<Leader>bo', CloseAllBuffersExceptCurrent, { desc = 'Close all buffers except current' })

-- Trim Microsoft line endings
function Trim()
  local save = vim.fn.winsaveview()
  vim.cmd('keeppatterns %s/\\s\\+$\\|\\r$//e')
  vim.fn.winrestview(save)

  local has_notify, notify = pcall(require, 'notify')
  if has_notify then
    vim.notify = notify
  end
  vim.notify('Trimmed ^M line endings', vim.log.levels.INFO)
end

vim.keymap.set('n', '<Leader>tt', Trim, { desc = 'Trimmed ^M line endings' })

-- Spell check current buffer and populate quickfix list
function SpellCheckToQuickfix()
  local qf_list = {}
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line_count = vim.api.nvim_buf_line_count(0)

  for lnum = 1, line_count do
    local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
    local col = 0
    while col < #line do
      local res = vim.fn.spellbadword(line:sub(col + 1))
      local badword = res[1]
      if badword == "" then
        break
      end

      local start_idx = line:find(badword, col + 1, true)
      if not start_idx then
        break
      end

      table.insert(qf_list, {
        bufnr = vim.api.nvim_get_current_buf(),
        lnum = lnum,
        col = start_idx,
        text = "Misspelled: " .. badword,
        type = 'W',
      })
      col = start_idx + #badword
    end
  end

  if #qf_list > 0 then
    vim.fn.setqflist(qf_list)
    vim.cmd('copen')
    vim.cmd('cfirst')
    local has_notify, notify = pcall(require, 'notify')
    if has_notify then
      notify('Found ' .. #qf_list .. ' spelling errors', vim.log.levels.WARN)
    end
  else
    local qf_open = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), 'buftype') == 'quickfix' then
        qf_open = true
        break
      end
    end
    if qf_open then
      vim.cmd('cclose')
    end
    vim.api.nvim_win_set_cursor(0, cursor)
  end
end

