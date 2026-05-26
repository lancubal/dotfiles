vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Add local bin to PATH
vim.env.PATH = vim.fn.expand('~/.local/bin') .. ':' .. vim.env.PATH

require('config.set')
require('config.misc')
require('config.lsp')
require('config.lazy_init')
require('config.remap')
