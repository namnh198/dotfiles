return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      return require "configs.nvimtree"
    end,
  },

  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    ---@module "auto-session"
    opts = {
      suppressed_dirs = { "~/Developer" },
    },
    config = function(_, opts)
      require("auto-session").setup(opts)
    end,
  },

  {
    "karb94/neoscroll.nvim",
    keys = { "<C-d>", "<C-u>" },
    config = function()
      require("neoscroll").setup {}
    end,
  },
}
