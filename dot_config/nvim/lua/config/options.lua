local o = vim.opt

-- vim.g.clipboard = {
--   name = "custom",
--   copy = {
--     ["+"] = "pbcopy",
--     ["*"] = "pbcopy",
--   },
--   paste = {
--     ["+"] = "pbpaste",
--     ["*"] = "pbpaste",
--   },
--   cache_enabled = 0,
-- }

vim.g.ai_cmp = false

-- Swap and backup
o.swapfile = false
o.backup = false
o.undodir = vim.fn.stdpath("data") .. "/undodir"
o.undofile = true
o.undolevels = 10000

-- Text wrapping
o.wrap = true
o.breakindent = true
