dofile(vim.g.base46_cache .. "nvimtree")

return {
  filters = {
    dotfiles = false,
    custom = {
      "^.git$",
      "^node_modules$",
      "^.DS_Store$",
      "^.next$",
    },
  },
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = { "help" },
  },
  view = {
    width = 30,
    preserve_window_proportions = true,
    relativenumber = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        item = "│ ",
        none = "  ",
      },
    },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = {
          unmerged = "",
          deleted = "",
          renamed = "➜",
          untracked = "",
          ignored = "◌",
          unstaged = "󰜀",
          staged = "✓",
        },
      },
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
}
