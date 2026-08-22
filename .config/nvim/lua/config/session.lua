local M = {}

-- Session options
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }

local session_dir = vim.fn.stdpath('state') .. '/sessions'
if vim.fn.isdirectory(session_dir) == 0 then
  vim.fn.mkdir(session_dir, 'p')
end

local last_session_file = session_dir .. '/last_session.vim'

-- Function to save the current session
function M.save_session(opts)
  opts = opts or {}
  -- Check if there are valid listed buffers
  local has_valid = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and vim.bo[buf].buftype == '' then
      has_valid = true
      break
    end
  end

  if not has_valid then
    return
  end

  vim.cmd('mksession! ' .. vim.fn.fnameescape(last_session_file))
  if opts.notify then
    local has_notify, notify = pcall(require, 'notify')
    if has_notify then
      notify('Sesión guardada correctamente', vim.log.levels.INFO)
    else
      print('Sesión guardada correctamente')
    end
  end
end

-- Function to restore the last session
function M.restore_session()
  if vim.fn.filereadable(last_session_file) == 1 then
    vim.cmd('silent! source ' .. vim.fn.fnameescape(last_session_file))
    local has_notify, notify = pcall(require, 'notify')
    if has_notify then
      notify('Última sesión restaurada exitosamente', vim.log.levels.INFO)
    else
      print('Última sesión restaurada exitosamente')
    end
  else
    local has_notify, notify = pcall(require, 'notify')
    if has_notify then
      notify('No se encontró ninguna sesión previa guardada', vim.log.levels.WARN)
    else
      print('No se encontró ninguna sesión previa guardada')
    end
  end
end

-- Auto-save session on exit
vim.api.nvim_create_autocmd('VimLeavePre', {
  group = vim.api.nvim_create_augroup('SessionAutoSave', { clear = true }),
  callback = function()
    M.save_session()
  end,
})

-- Startup prompt to restore session on VimEnter
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('SessionPromptRestore', { clear = true }),
  nested = true,
  callback = function()
    -- Skip if opened in diff mode or git commit
    if vim.opt.diff:get() or vim.bo.filetype == 'gitcommit' then
      return
    end

    if vim.fn.filereadable(last_session_file) == 1 then
      vim.defer_fn(function()
        local choice = vim.fn.confirm('¿Deseas restaurar la última sesión de Neovim?', "&Sí\n&No", 2)
        if choice == 1 then
          M.restore_session()
        end
      end, 20)
    end
  end,
})

-- Keymaps
vim.keymap.set('n', '<leader>rs', M.restore_session, { desc = '[R]estore last [S]ession' })
vim.keymap.set('n', '<leader>ss', function() M.save_session({ notify = true }) end, { desc = '[S]ave current [S]ession' })

return M
