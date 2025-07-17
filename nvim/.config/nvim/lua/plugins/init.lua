return {
  { "folke/trouble.nvim", cmd = "Trouble", opts = {} },

  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },

  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "codecompanion" },
    opts = {
      preview = {
        filetypes = { "md", "markdown", "codecompanion" },
      },
    },
  },
}
