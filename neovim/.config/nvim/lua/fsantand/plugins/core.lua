return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "c",
          "cpp",
          "go",
          "lua",
          "python",
          "tsx",
          "javascript",
          "typescript",
          "vimdoc",
          "vim",
          "bash",
          "jsdoc",
        },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.d2 = {
        install_info = {
          url = 'https://git.pleshevski.ru/pleshevskiy/tree-sitter-d2',
          revision = 'main',
          files = { 'src/parser.c', 'src/scanner.c' },
        },
        filetype = 'd2',
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
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
    keys = function ()
      local telescope_builtins = require("telescope.builtin")
      local find_current_word = function()
        local word = vim.fn.expand("<cword>")
        telescope_builtins.grep_string({ search = word })
      end

      return {
        { "<leader>pf", telescope_builtins.git_files, { desc = "Find repo files" }},
        { "<leader>pa", telescope_builtins.find_files, { desc = "Find all files" }},
        { "<leader>pd", telescope_builtins.oldfiles, { desc = "Find old files" }},
        { "<leader>ps", telescope_builtins.live_grep, { desc = "Live grep" }},
        { "<leader>po", telescope_builtins.lsp_dynamic_workspace_symbols, { desc = "Find lsp workspace symbols" }},
        { "<leader>pt", telescope_builtins.buffers, { desc = "Find open buffer" }},
        { "<leader>ph", telescope_builtins.help_tags, { desc = "Find help tags" }},
        { "<leader>pb", telescope_builtins.git_branches, { desc = "Switch branches" }},
        { "<leader>pT", ":Telescope colorscheme enable_preview=true <CR>", { desc = "Switch colorschemes" }},
        { "<leader>pws", find_current_word, { desc = "Find current word in files" }},
      }
    end,
    opts = function ()
      pcall(require("telescope").load_extension, "fzf")

      return {
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
          lsp_dynamic_workspace_symbols = { theme = 'dropdown' },
          oldfiles = { previewer = false, theme = 'dropdown'},
          git_files = { previewer = false, theme = 'dropdown'},
          find_files = { previewer = false, theme = 'dropdown'},
          buffers = { previewer = false, theme = 'dropdown'},
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
      }
    end,
  },
}
