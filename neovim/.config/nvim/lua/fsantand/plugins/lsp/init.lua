return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = { -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim" },
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
      -- -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
    config = function (_, opts)
      local lspconfig = require("lspconfig")

      local mappings = require("fsantand.plugins.lsp.keymaps")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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

      lspconfig.lua_ls.setup({
        on_attach = mappings.on_attach,
        capabilities = capabilities,
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = { disable = { "missing-fields" } },
          format = { enable = false },
        },
      })
    end
  },
}
