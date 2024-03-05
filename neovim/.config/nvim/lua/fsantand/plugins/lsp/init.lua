return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = { -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", opts={}, lazy=false },
      -- -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
    config = function (_, opts)
      local lspconfig = require("lspconfig")

      local mappings = require("fsantand.plugins.lsp.keymaps")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        "html",
        "lua_ls",
        "cssls",
        "clangd",
        "pyright",
        "gopls",
        "emmet_ls",
        "gdscript",
      }

      require("neodev").setup()

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          on_attach = mappings.on_attach,
          capabilities = capabilities,
        })
      end

      -- lua_ls
      lspconfig.lua_ls.setup({
        on_attach = mappings.on_attach,
        capabilities = capabilities,
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            -- Tells lua_ls where to find all the Lua files that you have loaded
            -- for your neovim configuration.
            library = {
              '${3rd}/luv/library',
              unpack(vim.api.nvim_get_runtime_file('', true)),
            },
            -- If lua_ls is really slow on your computer, you can try this instead:
            -- library = { vim.env.VIMRUNTIME },
          },
          completion = {
            callSnippet = 'Replace',
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      })

      -- Javascript n Typescript
      lspconfig.tsserver.setup({
        on_attach = mappings.on_attach,
        capabilities = capabilities,
        cmd = { "volta", "run", "typescript-language-server", "--stdio" },
      })
    end
  },
  {
    "j-hui/fidget.nvim",
    tag = "v1.2.0",
    event = "LspAttach",
    opts = {
      progress = {
        poll_rate = 100,              -- How and when to poll for progress messages
        suppress_on_insert = true,    -- Suppress new messages while in insert mode
        ignore_done_already = false,  -- Ignore new tasks that are already complete
        ignore_empty_message = false, -- Ignore new tasks that don't contain a message
        display = {
          render_limit = 16,
          group_style = "Title", -- Highlight group for group name (LSP server name)
        },
      },
    },
  },
}
