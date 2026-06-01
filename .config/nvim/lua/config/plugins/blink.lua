return {
  'saghen/blink.cmp',

  -- use a release tag to download pre-built binaries
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
    end,
    keymap = { preset = 'enter' },
    appearance = {
      nerd_font_variant = 'normal'
    },
    completion = { documentation = { auto_show = false } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
