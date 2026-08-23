local o = vim.opt

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
