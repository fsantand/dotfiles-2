return {
  "nvimtools/none-ls.nvim",
  event = "LspAttach",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local b = null_ls.builtins

    local sources = {
      -- Spellcheck
      b.code_actions.cspell,
    }

    null_ls.setup({
      sources = sources,
    })
  end,
}
