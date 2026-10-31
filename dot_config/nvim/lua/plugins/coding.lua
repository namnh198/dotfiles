return {
  {
    "stevearc/conform.nvim",
    lazy = true,
    opts = {
      formatters_by_ft = {
        yaml = { "yamlfmt" },
      },
      formatters = {
        yamlfmt = {
          command = "yamlfmt",
          args = { "-formatter", "basic", "-indentless_arrays=true" },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "LazyFile", "VeryLazy" },
    opts = {
      ensure_installed = {
        "graphql",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if not opts.servers then
        opts.servers = {}
      end
      opts.servers.gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            usePlaceholders = true,
            completeUnimported = true, -- This enables auto-import
            gofumpt = true,
          },
        },
      }
      opts.servers.html = {}
      opts.servers.cssls = {
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
          scss = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
          less = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      }
      return opts
    end,
  },
}
