-- Load defaults LSP nvchad (e.g lua_lsp)
require("nvchad.configs.lspconfig").defaults()

local servers = require("languages").lsp_servers

vim.lsp.enable(servers)

vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList" },
      emmetCompletions = true,
      hovers = true,
      suggestions = true,
      -- Uncomment if needed for shadcn UI
      -- experimental = {
      --   classRegex = {
      --     [["([^"]*)"]],
      --     [[`([^`]*)`]],
      --     [=[['"]([-\w\d]+)['"]\s*:\s*"([^"]*)"]=],
      --   },
      -- },
    },
  },
})

vim.lsp.config("vtsls", {
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  settings = {
    typescript = {
      format = {
        enable = true,
      },
      suggest = {
        completeFunctionCalls = true,
      },
    },
    javascript = {
      format = {
        enable = true,
      },
      suggest = {
        completeFunctionCalls = true,
      },
    },
    vtsls = {
      experimental = {
        enableProjectDiagnostics = true,
      },
    },
  },
})

-- Eslint language server
-- lspconfig.eslint.setup {
--   cmd = { "eslint" },
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   settings = {
--     workingDirectory = { mode = "auto" },
--   },
--   root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.json", ".eslintrc.js", "package.json", ".git"),
-- }
