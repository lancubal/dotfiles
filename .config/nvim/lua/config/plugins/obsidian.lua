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
        path = "/home/luna/obsidian-notes",
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
}
