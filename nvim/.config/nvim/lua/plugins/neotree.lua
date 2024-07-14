return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      sources = { "filesystem", "git_status" },
      enable_modified_markers = true,
      popup_border_style = "rounded",
      source_selector = {
        winbar = true,
        content_layout = "center",
        sources = { { source = "filesystem" }, { source = "git_status" } },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = { ".git", ".next", ".DS_Store", "node_modules" },
        },
        follow_current_file = { enabled = true },
      },
      renderer = {
        highlight_modified = "all",
        highlight_git = true,
      },
      window = {
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["z"] = "close_node",
          ["Z"] = "close_all_nodes",
          ["<TAB>"] = "next_source",
          ["<S-TAB>"] = "prev_source",
          ["l"] = "open_with_window_picker",
          ["o"] = "open",
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            deleted = "",
            renamed = "➜",
            untracked = "",
            ignored = "◌",
            unstaged = "󰜀",
            staged = "✓",
            conflict = "",
          },
        },
      },
    },
  },
}
