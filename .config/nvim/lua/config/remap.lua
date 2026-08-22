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

-- LSP Navigation
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]o to [D]efinition' })
vim.keymap.set('n', 'gr', function()
  require('telescope.builtin').lsp_references()
end, { desc = '[G]o to [R]eferences (Telescope)' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = '[G]o to [I]mplementation' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

--Buffer navigation
vim.keymap.set('n', '<Tab>', ':bn<CR>', { desc = 'Switches to next buffer' })
vim.keymap.set('n', '<S-Tab>', ':bp<CR>', { desc = 'Switches to previous buffer' })

-- Indentation
vim.keymap.set('n', '<leader><Tab>', '>>', { desc = 'Indent line' })
vim.keymap.set('n', '<leader><S-Tab>', '<<', { desc = 'De-indent line' })
vim.keymap.set('v', '<leader><Tab>', '>gv', { desc = 'Indent selection' })
vim.keymap.set('v', '<leader><S-Tab>', '<gv', { desc = 'De-indent selection' })

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

-- Git (Neogit & Diffview)
vim.keymap.set('n', '<leader>gs', '<cmd>Neogit<CR>', { desc = 'Open Neogit [G]it [S]tatus' })
vim.keymap.set('n', '<leader>dv', '<cmd>DiffviewOpen<CR>', { desc = 'Open [G]it [D]iffview' })
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', { desc = 'Open [G]it [H]istory for current file' })
vim.keymap.set('n', '<leader>gc', '<cmd>DiffviewClose<CR>', { desc = '[G]it Diffview [C]lose' })

-- Terminal
vim.keymap.set('n', '<leader>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.bo.bufhidden = 'wipe'
  vim.cmd.wincmd('J')
  vim.api.nvim_win_set_height(0, 15)
end, { desc = 'Terminal split bottom' })


-- Terminal mode escape
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Delete whole word in insert mode
vim.keymap.set('i', '<C-BS>', '<C-w>', { desc = 'Delete word backwards' })
vim.keymap.set('i', '<C-H>', '<C-w>', { desc = 'Delete word backwards' })
vim.keymap.set('i', '<C-Del>', '<C-o>dw', { desc = 'Delete word forward' })

-- Undo in insert mode
vim.keymap.set('i', '<C-z>', '<C-o>u', { desc = 'Undo in insert mode' })


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

vim.keymap.set('n', '<leader>hp', '<cmd>tabedit ~/.config/nvim/PLUGINS.md<CR>', { desc = 'Open [H]elp [P]lugins documentation' })

-- Quickfix navigation
vim.keymap.set('n', ']q', '<cmd>cnext<CR>zz', { desc = 'Next quickfix item' })
vim.keymap.set('n', '[q', '<cmd>cprev<CR>zz', { desc = 'Previous quickfix item' })
vim.keymap.set('n', '<leader>qc', '<cmd>cclose<CR>', { desc = '[Q]uickfix [C]lose' })

-- Spell checking
vim.keymap.set('n', '<leader>ts', function()
  vim.opt.spell = not vim.opt.spell:get()
  print("Spell checking: " .. (vim.opt.spell:get() and "ON" or "OFF"))
end, { desc = '[T]oggle [S]pell checking' })

vim.keymap.set('n', '<leader>zu', 'zuw', { desc = '[Z]pell [U]ndo (remove word from dictionary)' })

local function spell_suggest()
  local cursor_word = vim.fn.expand('<cword>')
  if cursor_word == '' then
    return
  end

  local suggestions = vim.fn.spellsuggest(cursor_word)
  local results = { "Add '" .. cursor_word .. "' to dictionary" }
  for _, s in ipairs(suggestions) do
    table.insert(results, s)
  end

  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local themes = require('telescope.themes')

  pickers
    .new(themes.get_cursor(), {
      prompt_title = 'Spell Suggestions',
      finder = finders.new_table({
        results = results,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection.index == 1 then
            vim.cmd('spellgood ' .. vim.fn.fnameescape(cursor_word))
          else
            -- selection.index is 2 for the first suggestion, which corresponds to 1z=
            vim.cmd('normal! ' .. (selection.index - 1) .. 'z=')
          end
        end)
        return true
      end,
    })
    :find()
end

vim.keymap.set('n', 'z=', spell_suggest, { desc = 'Spell suggestions via Telescope with Add to Dictionary' })

-- Automatic interactive Spell Check Wizard (<leader>za / <leader>zs)
local function spell_auto_check()
  vim.opt.spell = true

  -- Start from the beginning of the file
  vim.api.nvim_win_set_cursor(0, { 1, 0 })

  -- If the word at (1, 0) is not bad, jump to the first error
  if vim.fn.spellbadword()[1] == "" then
    vim.cmd('normal! ]s')
  end

  local initial_bad = vim.fn.spellbadword()[1]
  local initial_word = vim.fn.expand('<cword>')
  if initial_bad == "" or initial_word == "" then
    local has_notify, notify = pcall(require, 'notify')
    if has_notify then
      notify('✅ No se encontraron errores ortográficos', vim.log.levels.INFO)
    else
      print('✅ No se encontraron errores ortográficos')
    end
    return
  end

  local function step()
    local word = vim.fn.expand('<cword>')
    if word == '' or vim.fn.spellbadword()[1] == '' then
      local has_notify, notify = pcall(require, 'notify')
      if has_notify then
        notify('🎉 ¡Revisión completada! No quedan más errores.', vim.log.levels.INFO)
      else
        print('🎉 ¡Revisión completada! No quedan más errores.')
      end
      return
    end

    local suggestions = vim.fn.spellsuggest(word, 10)
    local results = {}
    for idx, s in ipairs(suggestions) do
      table.insert(results, { type = 'replace', idx = idx, replacement = s, text = s })
    end
    table.insert(results, { type = 'add', text = "➕ Añadir '" .. word .. "' al diccionario personal (zg)" })
    table.insert(results, { type = 'skip', text = "⏭️  Saltar este error (Ignorar)" })

    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local themes = require('telescope.themes')

    pickers
      .new(themes.get_cursor({
        layout_config = {
          width = 55,
          height = math.min(#results + 4, 15),
        },
      }), {
        prompt_title = "Corrección: '" .. word .. "'",
        finder = finders.new_table({
          results = results,
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.text,
              ordinal = entry.text,
            }
          end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if not selection then return end

            local val = selection.value
            local view = vim.fn.winsaveview()

            if val.type == 'replace' then
              local pattern = string.format([[\<%s\>]], vim.fn.escape(word, [[/\]]))
              local replacement = vim.fn.escape(val.replacement, [[/\]])
              pcall(vim.cmd, string.format('keeppatterns %%s/%s/%s/gI', pattern, replacement))
              vim.fn.winrestview(view)
            elseif val.type == 'add' then
              vim.cmd('spellgood ' .. vim.fn.fnameescape(word))
            elseif val.type == 'skip' then
              -- continue to next
            end



            -- Jump to next error automatically
            vim.defer_fn(function()
              local prev_pos = vim.api.nvim_win_get_cursor(0)
              vim.cmd('normal! ]s')
              local next_pos = vim.api.nvim_win_get_cursor(0)

              local next_bad = vim.fn.spellbadword()[1]
              local moved_forward = (next_pos[1] > prev_pos[1]) or (next_pos[1] == prev_pos[1] and next_pos[2] > prev_pos[2])

              if moved_forward and next_bad ~= "" then
                vim.cmd('normal! zz')
                step()
              else
                local has_notify, notify = pcall(require, 'notify')
                if has_notify then
                  notify('🎉 ¡Revisión completada! No quedan más errores.', vim.log.levels.INFO)
                else
                  print('🎉 ¡Revisión completada! No quedan más errores.')
                end
              end
            end, 30)
          end)
          return true
        end,
      })
      :find()
  end

  vim.cmd('normal! zz')
  step()
end

vim.keymap.set('n', '<leader>za', spell_auto_check, { desc = '[Z]pell [A]uto: wizard interactivo de corrección continua' })
vim.keymap.set('n', '<leader>zs', spell_auto_check, { desc = '[Z]pell [S]tart: wizard interactivo de corrección continua' })




