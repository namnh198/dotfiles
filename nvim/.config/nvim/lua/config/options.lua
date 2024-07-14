-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

vim.g.lazyvim_picker = "telescope"

-- Check if clipboard support is available
if vim.fn.has("clipboard") == 1 then
  -- Set the '_' register for clipboards opearations
  opt.clipboard:append("unnamedplus")
end
