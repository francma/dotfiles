-- vim: expandtab:ts=2:sw=2:

vim.opt.swapfile = false
vim.opt.termguicolors = true 
vim.opt.relativenumber = true
vim.opt.hlsearch = true
vim.opt.showmode = false
vim.g.mapleader = ","

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

require "paq" {
  "editorconfig/editorconfig-vim",
  "b3nj5m1n/kommentary",
  "loctvl842/monokai-pro.nvim",
  "nvim-treesitter/nvim-treesitter",
}

require("monokai-pro").setup({

})

vim.cmd([[colorscheme monokai-pro]])

require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "php", "python" },
  auto_install = false,
  highlight = {
    enable = true,
  },
})
