require "nvchad.mappings"

local map = vim.keymap.set

-- general
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- save file
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><ESC>")

-- select all
map({ "n", "i", "v" }, "<C-a>", "gg<S-v>G")

-- split window
map("n", "ss", ":split<return>", { desc = "split horizontal" })
map("n", "sv", ":vsplit<return>", { desc = "split vertical" })

-- buffer close
map("n", "<leader>xr", function()
  require("nvchad.tabufline").closeBufs_at_direction "right"
end, { desc = "buffer close to the right" })

map("n", "<leader>xl", function()
  require("nvchad.tabufline").closeBufs_at_direction "left"
end, { desc = "buffer close to the left" })

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

map("x", "<leader>d", "y'o<ESC>p", { desc = "duplicate selected", noremap = true, silent = true })
map("x", "<leader>xo", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and not vim.bo[buf].modified then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, { desc = "close all saved buffer" })
