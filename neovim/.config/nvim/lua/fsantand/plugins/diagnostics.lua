return {
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Trouble",
    opts = {},
    keys = {
      {
        "<leader>qa",
        "<cmd>Trouble diagnostics toggle<CR>",
        desc = "Diagnostics: Workspace",
      },
      {
        "<leader>qd",
        "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
        desc = "Diagnostics: Document",
      },
      {
        "<leader>qs",
        "<cmd>Trouble symbols toggle focus=false win.position=bottom<CR>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>ql",
        "<cmd>Trouble lsp toggle focus=false win.position=bottom<CR>",
        desc = "Lsp Definitions (Trouble)",
      },
    },
  },
}
