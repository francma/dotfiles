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
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "nvim-treesitter/nvim-treesitter",
}

require("monokai-pro").setup({})
vim.cmd([[colorscheme monokai-pro]])

local cmp = require("cmp")
local caps = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("gopls", {
  capabilities = caps,
})

vim.lsp.enable("gopls")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  sources = {
    { name = "nvim_lsp" },
  },
})

require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install({ "go", "lua" })

-- clear search highlight
vim.keymap.set("n", "<C-l>", ":nohlsearch<CR><C-l>", { silent = true })

-- go to declaration
vim.keymap.set("n", "gd", vim.lsp.buf.definition)

-- references / usages
vim.keymap.set("n", "gr", vim.lsp.buf.references)

-- implementations
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)

-- hover docs
vim.keymap.set("n", "K", vim.lsp.buf.hover)

-- rename symbol
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

-- parameter info / signature help
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)

-- next / previous diagnostic
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)

-- format selected buffer
vim.keymap.set("x", "<leader>ff", function()
  vim.lsp.buf.format()
end)

vim.keymap.set("n", "<leader>ff", function()
  vim.lsp.buf.format()
end)

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
