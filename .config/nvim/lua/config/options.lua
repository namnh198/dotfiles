local o = vim.opt

-- Fix clipboard not provider in orbstack linux machine
if vim.env.NVIM_CLIPBOARD then
  vim.g.clipboard = {
    name = vim.env.NVIM_CLIPBOARD,
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
    cache_enabled = 0,
  }
end

vim.g.ai_cmp = false

-- Make sure all keymaps silent by default
local map = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return map(mode, lhs, rhs, opts)
end

-- Swap
o.swapfile = false

-- Text wrapping
o.wrap = true
o.breakindent = true

-- Search
o.ignorecase = true
o.smartcase = true
