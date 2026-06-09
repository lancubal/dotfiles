return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  lazy = false,
  build = ':TSUpdate',

  config = function()
    require('nvim-treesitter').setup({
      ensure_installed = {
        'javascript',
        'typescript',
        'tsx',
        'json',
        'jsdoc',
        'html',
        'css',
        'regex',
        'markdown',
        'markdown_inline',
        'haskell',
        'latex',
        'lua',
        'query',
      },
      highlight = {
        enable = true,
      },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
      },
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'dart',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
