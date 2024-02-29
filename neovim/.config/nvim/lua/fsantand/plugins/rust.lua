return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          src = {
            cmp = { enabled = true },
          },
        },
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "crates" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "codelldb" })
      end
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      {
        "lvimuser/lsp-inlayhints.nvim",
        opts = {}
      },
    },
    keys = function ()
      return {
        { "<leader>ca", ":RustLsp codeAction<CR>", "Rust: [C]ode [a]ctions"},
        { "gd", require("telescope.builtin").lsp_definitions, "Rust: [G]oto [D]efinition" },
        { "gr", require("telescope.builtin").lsp_references, "Rust: [G]oto [R]eferences" },
        { "gI", ":RustLsp hover actions<CR>", "Rust: [G]oto [I]mplementation" },
        { "K", ":RustLsp hover actions<CR>", "Rust: Hover documentation" },
        { "ge", ":RustLsp explainError<CR>", "Rust: [G]oto [E]rror explanation" },
        { "<leader>vd", ":RustLsp renderDiagnostic<CR>", "Rust: [V]iew [D]iagnostic" },
        { "<leader>D", require("telescope.builtin").lsp_type_definitions, "Rust: Type [D]efinition" },
        { "<leader>ds", require("telescope.builtin").lsp_document_symbols, "Rust: [D]ocument [S]ymbols" },
        { "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Rust: [W]orkspace [S]ymbols" },
        { "<F5>", ":RustLsp debuggables<CR>" , "Rust: Debug" },
      }
    end,
    config = function()
      vim.g.rustaceanvim = {
        inlay_hints = {
          highlight = "NonText",
        },
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = function(client, bufnr)
            require("lsp-inlayhints").on_attach(client, bufnr)
          end
        }
      }
    end
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = {
      adapters = {
        ["neotest-rust"] = {},
      },
    },
  },
}
