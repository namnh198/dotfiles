require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("nvchad_" .. name, { clear = true })
end

-- highlight on yank
autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- treesitter
autocmd("FileType", {
  callback = function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
      vim.treesitter.start()
    end
  end,
})

-- show nvdash if all buffers removed
autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
  group = augroup "wrap_shell",
  pattern = { "text", "plaintext", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- fix conceallevel for json files
autocmd("FileType", {
  group = augroup "json_conceal",
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- auto create dir when saving file, in case something intermediate directory does not exists
autocmd("BufWritePre", {
  group = augroup "auto_create_dir",
  callback = function(event)
    if event.match:match "^%w%w+:[\\/][\\/]" then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    if client.name == "biome" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("BiomeFixAll", { clear = true }),
        callback = function()
          vim.lsp.buf.code_action {
            context = {
              ---@diagnostic disable-next-line: assign-type-mismatch
              only = { "source.fixAll.biome" },
              diagnostics = {},
            },
            apply = true,
          }
        end,
      })
    end

    if client:supports_method "textDocument/completion" then
      vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      vim.keymap.set("i", "<C-Space>", function()
        vim.lsp.completion.get()
      end)
    end
  end,
})

-- hide tmux status
autocmd({ "VimEnter", "VimLeave" }, {
  group = augroup "tmux",
  callback = function(args)
    if not vim.fn.executable "tmux" then
      return
    end
    vim.cmd "silent !tmux set status off"

    if args.event == "VimLeave" then
      vim.cmd "silent !tmux set status on"
    end
  end,
})
