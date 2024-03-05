return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        commit = "73e44f43c70289c70195b5e7bc6a077ceffddda4",
      },
    },
    build = ":TSUpdate",
    opts = {
      -- Add languages to be installed here that you want installed for treesitter
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
    }
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
      }
    end,
  },
}
