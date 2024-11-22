return {
  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",

      -- Adds a number of user-friendly snippets
      "rafamadriz/friendly-snippets",
    },
    opts = function ()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({})

      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- ["<C-y>"] = cmp.mapping.complete({
          --   select = true,
          --   behaviour = cmp.ConfirmBehavior.Replace,
          -- }),
          ["<C-y>"] = cmp.mapping.confirm({
            behaviour = cmp.ConfirmBehavior.Replace,
            select = true
          }),
        }),
        sources = {
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "luasnip" },
          { name = "path" },
        },
      }
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    enabled = false,
    main = "ibl",
    opts = {
      exclude = {
        filetypes = {
          "dashboard",
        },
      },
    },
  },
  {
    'goolord/alpha-nvim',
    config = function ()
      local alpha = require'alpha'
      local theta = require'alpha.themes.theta'
      local dashboard = require'alpha.themes.dashboard'

      theta.buttons.val = {
        { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
        { type = "padding", val = 1 },
        dashboard.button("e", "  New file", "<cmd>ene<CR>"),
        dashboard.button("SPC p f", "󰈞  Find file"),
        dashboard.button("SPC p s", "󰊄  Live grep"),
        dashboard.button("c", "  Configuration", "<cmd>cd ~/.config/nvim/ <CR>"),
        dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
        dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
      }

      theta.header.val = {
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⣤⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⠟⠉⠉⠉⠉⠉⠉⠉⠙⠻⢶⣄⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣷⡀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡟⠀⣠⣶⠛⠛⠛⠛⠛⠛⠳⣦⡀⠀⠘⣿⡄⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⠁⠀⢹⣿⣦⣀⣀⣀⣀⣀⣠⣼⡇⠀⠀⠸⣷⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⡏⠀⠀⠀⠉⠛⠿⠿⠿⠿⠛⠋⠁⠀⠀⠀⠀⣿  ]],
        [[⠀⠀      ⢠⣿       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡇⠀]],
        [[       ⠀⣸⡇⠀           ⠀⠀⠀⠀⠀⢸⡇⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⣿⠁⠀⠀⠀N⠀E⠀O⠀V⠀I⠀M⠀⠀⠀⢸⣧⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⢸⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⣾⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⣿⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⣿⠀]],
        [[⠀⠀⠀⠀⠀⠀⢰⣿⠀⠀⠀⠀⣠⡶⠶⠿⠿⠿⠿⢷⣦⠀⠀⠀    ⣿⠀]],
        [[⠀⠀⣀⣀⣀⠀⣸⡇⠀⠀⠀⠀⣿⡀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⣿⠀]],
        [[⣠⡿⠛⠛⠛⠛⠻⠀⠀⠀⠀⠀⢸⣇⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀ ⠀⣿⠀]],
        [[⢻⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⡟⠀⠀⢀⣤⣤⣴⣿⠀⠀⠀⠀  ⠀⣿⠀]],
        [[⠈⠙⢷⣶⣦⣤⣤⣤⣴⣶⣾⠿⠛⠁⢀⣶⡟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡟⠀]],
        [[          ⠀⠀⠀⠀⠈⣿⣆⡀⠀⠀⠀⠀⠀⠀⢀⣠⣴⡾⠃⠀]],
        [[         ⠀⠀⠀⠀⠀⠀⠈⠛⠻⢿⣿⣾⣿⡿⠿⠟⠋⠁⠀⠀⠀]],
      }


      alpha.setup(theta.config)
    end
  },
  {
    "tpope/vim-sleuth",
    lazy = false,
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function ()
      require("oil").setup()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = {}
  }
}
