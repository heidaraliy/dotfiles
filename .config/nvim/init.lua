-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- leader key
vim.g.mapleader = " "

-- setup plugins
require("lazy").setup({
  -- LSP configs (provides server definitions like clangd)
  { "neovim/nvim-lspconfig" },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = {
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = "nvim_lsp" },
        },
      })
    end,
  },
})

-- keymaps
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- Neovim 0.11+ native LSP config
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- only add cmp capabilities if cmp is installed/loaded
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

vim.lsp.config("clangd", {
  cmd = { "clangd", "--background-index" },
  capabilities = capabilities,
})
vim.lsp.enable("clangd")

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = false
