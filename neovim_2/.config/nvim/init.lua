vim.g.mapleader = " "
vim.o.mouse = ""
vim.o.termguicolors = true
vim.g.maplocalleader = "\\ "
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = ""
vim.o.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.o.clipboard = "unnamedplus"
vim.cmd([["filetype plugin on"]])


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "tpope/vim-surround",
  "tpope/vim-fugitive",
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = { -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
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
  },
  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
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
  },
  { "folke/which-key.nvim",  opts = {} },
  {
    "rebelot/kanagawa.nvim",
    opts = {},
    config = function()
      vim.cmd.colorscheme("kanagawa")
    end,
    priority = 5000,
  },
  {
    "loctvl842/monokai-pro.nvim",
    opts = {
      transparent_background = false,
      inc_search = "underline",
    },
    enabled = false,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
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
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        commit = "73e44f43c70289c70195b5e7bc6a077ceffddda4",
      },
    },
    build = ":TSUpdate",
    tag = "v0.9.1",
  },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ "n", "v" }, "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Jump to next hunk" })

        map({ "n", "v" }, "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Jump to previous hunk" })

        -- Actions
        -- visual mode
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "stage git hunk" })
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "reset git hunk" })
        -- normal mode
        map("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "preview git hunk" })
        map("n", "<leader>gb", function()
          gs.blame_line({ full = false })
        end, { desc = "git blame line" })
        map("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "git diff against last commit" })

        -- Toggles
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
      end,
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {},
  },
  {
    "Wansmer/treesj",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
  { "numToStr/Comment.nvim", opts = {} },
  {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
  },
  require("fsantand.plugins.lualine"),
  require("fsantand.plugins.null-ls"),
  require("fsantand.plugins.debugger"),
  require("fsantand.plugins.neotest"),
  require("fsantand.plugins.harpoon"),
  require("fsantand.plugins.conform"),
  require("fsantand.plugins.linter"),
  require("fsantand.plugins.alpha"),
  -- require("fsantand.plugins.rustaceannvim"),
})

vim.o.undofile = true
vim.o.breakindent = true
vim.wo.signcolumn = "yes"

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

local open_float = function()
  return vim.diagnostic.open_float({ border = "rounded" })
end

local goto_next_diag = function()
  return vim.diagnostic.goto_next({ border = "rounded" })
end

local goto_prev_diag = function()
  return vim.diagnostic.goto_prev({ border = "rounded" })
end

-- [[ Default ]]
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move to next half page" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move to prev half page" })
vim.keymap.set("n", "<leader>rn", ":set relativenumber!<CR>", { silent = true, desc = "Move to prev half page" })

-- [[ Diagnostics ]]
vim.keymap.set("n", "<leader>vd", open_float, { desc = "Open diagnostic" })
vim.keymap.set("n", "]d", goto_next_diag, { desc = "Diagnostics: Go to next" })
vim.keymap.set("n", "[d", goto_prev_diag, { desc = "Diagnostics: Go to previous" })
vim.keymap.set("n", "<leader>qd", ":TroubleToggle workspace_diagnostics<CR>", { desc = "Diagnostics: Open QF" })
vim.keymap.set("n", "<leader>qa", ":TroubleToggle document_diagnostics<CR>", { desc = "Diagnostics: Open QF" })

-- [[ NETRW ]]
vim.keymap.set("n", "-", ":Ex<CR>", { silent=true, desc = "Open file directory" })
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = '\\(^\\|\\s\\s\\)\\zs\\.\\S\\+'


-- [[ Telescope ]]
local telescope_builtins = require("telescope.builtin")
require("telescope").setup({
  vimgrep_arguments = {
    "rg",
    "-L",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
  },
  pickers = {
    lsp_dynamic_workspace_symbols = { previewer = false, theme = 'dropdown' },
    oldfiles = { previewer = false, theme = 'dropdown'},
    git_files = { previewer = false, theme = 'dropdown'},
    find_files = { previewer = false, theme = 'dropdown'},
    buffers = { previewer = false, theme = 'cursor'},
    help_tags = { theme = 'dropdown'},
  },
  file_sorter = require("telescope.sorters").get_fuzzy_file,
  file_ignore_patterns = { "node_modules", "package%-lock.json" },
  generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
    },
  },
})

pcall(require("telescope").load_extension, "fzf")

vim.keymap.set("n", "<leader>pf", telescope_builtins.git_files, { desc = "Find repo files" })
vim.keymap.set("n", "<leader>pa", telescope_builtins.find_files, { desc = "Find all files" })
vim.keymap.set("n", "<leader>pd", telescope_builtins.oldfiles, { desc = "Find old files" })
vim.keymap.set("n", "<leader>ps", telescope_builtins.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>po", telescope_builtins.lsp_dynamic_workspace_symbols, { desc = "Find lsp workspace symbols" })
vim.keymap.set("n", "<leader>pt", telescope_builtins.buffers, { desc = "Find open buffer" })
vim.keymap.set("n", "<leader>ph", telescope_builtins.help_tags, { desc = "Find help tags" })
vim.keymap.set("n", "<leader>pb", telescope_builtins.git_branches, { desc = "Switch branches" })
vim.keymap.set("n", "<leader>pws", function()
  local word = vim.fn.expand("<cword>")
  telescope_builtins.grep_string({ search = word })
end, { desc = "Find current word in files" })

-- [[ Treesitter ]]
vim.defer_fn(function()
  require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      "c",
      "cpp",
      "go",
      "lua",
      "python",
      "rust",
      "tsx",
      "javascript",
      "typescript",
      "vimdoc",
      "vim",
      "bash",
      "jsdoc",
    },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<M-space>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  })
end, 0)

-- [[ LSP ]]
require("mason").setup({})
local mason_lspconfig = require("mason-lspconfig")

local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = { disable = { "missing-fields" } },
      format = { enable = false },
    },
  },
  html = {},
  cssls = {},
  clangd = {},
  pyright = {},
  gopls = {},
  emmet_ls = {},
  tsserver = {
    cmd = { "volta", "run", "typescript-language-server", "--stdio" },
  },
  rust_analyzer = {},
}

require("neodev").setup()

local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>ra", vim.lsp.buf.rename, "[R]en[a]me")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [a]ctions")

  nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  vim.keymap.set("i", "<C-S-h>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    })
  end,
})

local lspconfig = require("lspconfig")
local extra_servers = {
  "gdscript",
}

for _, server in ipairs(extra_servers) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- [[ CMP ]]
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
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
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm(),
  }),
  sources = {
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "path" },
  },
})
