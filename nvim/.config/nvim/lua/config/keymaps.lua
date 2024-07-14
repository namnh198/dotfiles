-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- code folding
keymap.set("n", "-", "<cmd>foldclose<CR>", { desc = "Close code folding", noremap = true, remap = true })
keymap.set("n", "+", "<cmd>foldopen<CR>", { desc = "Open code folding", noremap = true, remap = true })

-- save files
keymap.set({ "n", "i", "x", "s" }, "<D-s>", "<cmd>w<CR><esc>", { desc = "Save file", remap = true })

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Selected all" })

-- disable continuations
keymap.set("n", "<leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tabs
keymap.set("n", "te", ":tabedit")

-- Switch buffer
keymap.set("n", "<tab>", ":bnext<Return>", { desc = "Previous Buffer", noremap = true, silent = true })
keymap.set("n", "<S-tab>", ":bprev<Return>", { desc = "Next Buffer", noremap = true, silent = true })

-- Split windows
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move windows
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize windows
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostic
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end)
