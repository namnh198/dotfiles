require "nvchad.mappings"

local map = vim.keymap.set

-- general
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><ESC>")
map({ "n", "i", "v" }, "<C-a>", "gg<S-v>G")
map("x", "<leader>d", "y'o<ESC>p", { desc = "duplicate selected", noremap = true, silent = true })

-- split window
map("n", "ss", ":split<return>", { desc = "split horizontal" })
map("n", "sv", ":vsplit<return>", { desc = "split vertical" })

-- Tabufline
map("n", "<leader>xr", function()
  require("nvchad.tabufline").closeBufs_at_direction "right"
end, { desc = "buffer close to the right" })

map("n", "<leader>xl", function()
  require("nvchad.tabufline").closeBufs_at_direction "left"
end, { desc = "buffer close to the left" })

map("n", "<leader>xo", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "buffer close other" })

map("n", "<leader>xa", function()
  require("nvchad.tabufline").closeAllBufs(true)
end, { desc = "buffer close all" })
-- copying filepath
map("n", "<leader>cf", function()
  local path = vim.fn.expand "%"
  vim.fn.setreg("+", path)
  vim.notify("copied relative path:\n" .. path)
end, { desc = "copy relative path", noremap = true, silent = true })

map("n", "<leader>cF", function()
  local path = vim.fn.expand "%:p"
  vim.fn.setreg("+", path)
  vim.notify("copied absolute path:\n" .. path)
end, { desc = "copied absolute path", noremap = true, silent = true })

-- Open Menu (Volt)
map({ "n", "v" }, "<RightMouse>", function()
  require("menu.utils").delete_old_menus()
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

map("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-- Telescope
map("n", ";;", function()
  local builtin = require "telescope.builtin"
  builtin.resume()
end, { desc = "telescope resume the previous picker" })

map("n", ";s", function()
  local builtin = require "telescope.builtin"
  builtin.treesitter()
end, { desc = "telescope list functions, variables from treesitter" })

map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })

map("n", "<leader>fs", function()
  require("telescope.builtin").lsp_document_symbols { symbols = "function" }
end, { desc = "Find functions in current file" })

-- LSP / Code actions
map({ "n", "i" }, "<C-z>", vim.lsp.buf.signature_help, { desc = "LSP Signature Help", noremap = true, silent = true })

map("n", "<leader>ca", function()
  require("tiny-code-action").code_action()
end, { desc = "LSP Code Actions", noremap = true, silent = true })

-- Formatting
map("n", "<leader>fp", function()
  require("scripts.prettier").format_with_tailwind()
end, { desc = "Format file with Tailwind" })

-- Lazygit
map({ "n", "t" }, "<A-g>", function()
  if vim.fn.executable "lazygit" then
    require("nvchad.term").toggle {
      pos = "float",
      id = "fl_lazy",
      cmd = "lazygit",
    }
  end
end, { desc = "toggle lazyGit terminal", silent = true })
