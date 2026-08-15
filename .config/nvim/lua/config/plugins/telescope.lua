return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
  },
  module = 'telescope',

  config = function()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = { 'undodir/.*' },
      },

      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [G]it files' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[F]ind [R]ecent files' })
    vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = '[F]ind [String] in files' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    vim.keymap.set(
      'n',
      '<leader>fh',
      ':Telescope find_files hidden=true <CR>',
      { desc = '[F]ind [H]idden files' }
    )
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Custom picker for PLUGINS.md shortcuts
    local function search_plugins_shortcuts()
      local file_path = vim.fn.stdpath('config') .. '/PLUGINS.md'
      if vim.fn.filereadable(file_path) ~= 1 then
        vim.notify('PLUGINS.md not found at ' .. file_path, vim.log.levels.WARN)
        return
      end

      local lines = vim.fn.readfile(file_path)
      local entries = {}
      local current_category = 'General'

      for lnum, line in ipairs(lines) do
        local cat = line:match('^###%s+(.*)') or line:match('^##%s+(.*)')
        if cat then
          current_category = cat:gsub('^[^\xa0-\xff%w%s]+%s*', '')
        elseif line:match('^|%s*`') or (line:match('^|') and not line:match('^|%s*%-') and not line:match('^|%s*Atajo') and not line:match('^|%s*Plugin')) then
          local cells = {}
          for cell in line:gmatch('|%s*([^|]+)%s*') do
            table.insert(cells, vim.trim(cell))
          end

          if #cells >= 2 then
            local key = cells[1]:gsub('`', '')
            local desc = cells[2]
            local mode = cells[3] or ''

            table.insert(entries, {
              category = current_category,
              key = key,
              desc = desc,
              mode = mode,
              lnum = lnum,
              ordinal = current_category .. ' ' .. key .. ' ' .. desc .. ' ' .. mode,
            })
          end
        end
      end

      local pickers = require('telescope.pickers')
      local finders = require('telescope.finders')
      local conf = require('telescope.config').values
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local entry_display = require('telescope.entry_display')

      local displayer = entry_display.create({
        separator = ' │ ',
        items = {
          { width = 24 },
          { width = 20 },
          { remaining = true },
        },
      })

      local make_display = function(entry)
        local mode_str = entry.value.mode ~= '' and (' [' .. entry.value.mode .. ']') or ''
        return displayer({
          { '[' .. entry.value.category .. ']', 'TelescopeResultsIdentifier' },
          { entry.value.key, 'TelescopeResultsFunction' },
          { entry.value.desc .. mode_str, 'TelescopeResultsNormal' },
        })
      end

      pickers
        .new(require('telescope.themes').get_dropdown({
          layout_config = {
            width = 0.90,
            height = 0.80,
          },
        }), {
          prompt_title = '⚡ Shortcuts & Keymaps (PLUGINS.md)',
          finder = finders.new_table({
            results = entries,
            entry_maker = function(entry)
              return {
                value = entry,
                display = make_display,
                ordinal = entry.ordinal,
                lnum = entry.lnum,
                filename = file_path,
              }
            end,
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              if selection then
                vim.cmd('tabedit ' .. vim.fn.fnameescape(file_path))
                vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
              end
            end)
            return true
          end,
        })
        :find()
    end

    vim.keymap.set('n', '<leader>sk', search_plugins_shortcuts, { desc = '[S]earch [K]eymaps from PLUGINS.md' })
    vim.keymap.set('n', '<leader>fk', search_plugins_shortcuts, { desc = '[F]ind [K]eymaps from PLUGINS.md' })
    vim.keymap.set('n', '<leader>hk', search_plugins_shortcuts, { desc = '[H]elp [K]eymaps from PLUGINS.md' })
  end,
}

