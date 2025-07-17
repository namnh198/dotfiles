require "nvchad.options"

local o = vim.o

-- Clipboard
o.clipboard = "unnamedplus"

-- Swap
o.swapfile = false

-- Relative and Absolute line number combined
o.number = true
o.relativenumber = true
o.ruler = false

-- Cursorline
o.cursorlineopt = "both"

-- Text wrapping
o.wrap = true
o.breakindent = true

-- Session
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Search
o.ignorecase = true
o.smartcase = true

-- Folding
o.foldlevel = 20
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = false -- disable folding startup

-- Save undo history
o.undofile = true
