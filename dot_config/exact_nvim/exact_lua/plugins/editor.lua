return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    },
    opts = {
      options = {
        -- separator_style = "slope",
        -- always_show_bufferline = false,
      },
    },
  },
  {
    "nvim-mini/mini.icons",
    opts = {
      extension = {
        ["astro"] = { glyph = "", hl = "MiniIconsRed" },
      },
    },
  },
  -- snack
  {
    "folke/snacks.nvim",
    ---@diagnostic disable-next-line: unused-local
    opts = function(_, opts)
      local sources = opts.picker.sources or {}
      local source_names = { "files", "explorer", "grep", "grep_word", "grep_buffers" }
      local source_opts = {
        hidden = true,
        ignored = true,
        exclude = { ".git", ".DS_Store", ".vscode", ".idea", "node_modules", ".next", "vendor" },
      }

      for _, name in ipairs(source_names) do
        sources[name] = source_opts
      end
      opts.picker.sources = sources

      return opts
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
