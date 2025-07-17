-- Load defaults LSP nvchad (e.g lua_lsp)
require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {},
  cssls = {},
  tailwindcss = {
    settings = {
      tailwindCSS = {
        classAttributes = { "class", "className", "classList" },
        emmetCompletions = true,
        hovers = true,
        suggestions = true,
        -- Uncomment if needed for shadcn/ui
        experimental = {
          classRegex = {
            { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
            { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          },
        },
      },
    },
  },
  biome = {},
  eslint = {
    settings = {
      workingDirectory = { mode = "auto" },
    },
  },
  jsonls = {},
  vtsls = {
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    settings = {
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        format = {
          enable = true,
        },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
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
  },
}

for name, opts in pairs(servers) do
  vim.lsp.enable(name) -- nvim v0.11.0 or above required
  vim.lsp.config(name, opts) -- nvim v0.11.0 or above required
end

local lspconfig = require "lspconfig"

-- Configurar emmet_ls
lspconfig.emmet_ls.setup {
  on_attach = function(client, bufnr)
    -- Limitar Emmet a contextos específicos
    local filetype = vim.bo[bufnr].filetype
    if filetype == "javascript" or filetype == "typescript" then
      -- Deshabilitar autocompletado de Emmet
      client.server_capabilities.completionProvider = nil
    end
  end,
  filetypes = { "html", "css", "javascriptreact", "typescriptreact" }, -- Solo para tipos de archivo relevantes
}
