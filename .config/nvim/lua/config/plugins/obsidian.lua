return {
  "epwalsh/obsidian.nvim",
  version = "*", -- use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = function()
          local candidates = {
            vim.fn.expand("~/Documents/Notas"),
            vim.fn.expand("~/obsidian-notes"),
            vim.fn.expand("~/Notas"),
          }
          for _, path in ipairs(candidates) do
            if vim.fn.isdirectory(path) == 1 then
              return path
            end
          end
          return vim.fn.expand("~/Documents/Notas")
        end,
      },
    },
    completion = {
      nvim_cmp = false, -- We use blink.cmp
      min_chars = 2,
    },
    -- Control how notes are named
    note_id_func = function(title)
      -- Use the title as the note ID, fallback to timestamp if no title
      if title ~= nil then
        return title
      end
      return tostring(os.time())
    end,
    mappings = {
      -- "Obsidian follow" - salta al link bajo el cursor
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Alternar checkboxes
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Renombrar nota y actualizar referencias
      ["<leader>rn"] = {
        action = function()
          return ":ObsidianRename "
        end,
        opts = { buffer = true, expr = true },
      },
    },
    -- Configuración de cómo se ven los links
    ui = {
      enable = true,
    },
  },
  config = function(_, opts)
    local obsidian = require("obsidian")
    obsidian.setup(opts)

    local Client = require("obsidian.client")
    local orig_follow = Client.follow_link_async

    Client.follow_link_async = function(self, link, follow_opts)
      follow_opts = follow_opts and follow_opts or {}
      local cur_buf_name = vim.api.nvim_buf_get_name(0)

      self:resolve_link_async(link, function(...)
        local results = { ... }
        if #results == 0 then
          return
        end

        local function follow_link(res)
          if res.url ~= nil then
            if self.opts.follow_url_func ~= nil then
              self.opts.follow_url_func(res.url)
            else
              vim.ui.open(res.url)
            end
            return
          end

          if res.note ~= nil then
            return self:open_note(res.note, { line = res.line, col = res.col, open_strategy = follow_opts.open_strategy, sync = true })
          end

          local search = require("obsidian.search")
          if res.link_type == search.RefTypes.Wiki or res.link_type == search.RefTypes.WikiWithAlias then
            local util = require("obsidian.util")
            if util.confirm("Create new note '" .. res.location .. "'?") then
              local id, aliases
              if res.name == res.location then
                aliases = {}
              else
                aliases = { res.name }
                id = res.location
              end

              local note = self:create_note { title = res.name, id = id, aliases = aliases, no_write = true }
              return self:open_note(note, {
                open_strategy = follow_opts.open_strategy,
                sync = true,
                callback = function(bufnr)
                  self:write_note_to_buffer(note, { bufnr = bufnr })
                end,
              })
            else
              return
            end
          end
        end

        vim.schedule(function()
          -- 1. Filtrar el archivo actual para no saltar a la misma nota en la que estamos
          local filtered = {}
          for _, res in ipairs(results) do
            if not (res.path and tostring(res.path) == cur_buf_name and res.line == nil) then
              table.insert(filtered, res)
            end
          end
          if #filtered > 0 then
            results = filtered
          end

          if #results == 1 then
            follow_link(results[1])
            return
          end

          -- 2. Priorizar coincidencia exacta por nombre de archivo / ID sobre coincidencias de títulos de headers
          local exact = nil
          for _, res in ipairs(results) do
            if res.note and res.location then
              local loc = string.lower(res.location)
              local note_id = string.lower(res.note.id)
              local note_stem = res.note.path and string.lower(res.note.path.stem or "") or ""
              if note_id == loc or note_stem == loc then
                exact = res
                break
              end
            end
          end

          if exact then
            follow_link(exact)
            return
          end

          -- 3. Fallback al picker original si hay ambigüedad genuina
          orig_follow(self, link, follow_opts)
        end)
      end)
    end
  end,
}

