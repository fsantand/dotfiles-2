return {
  "jose-elias-alvarez/null-ls.nvim",
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
      b.formatting.prettier.with({ filetypes = { "html", "markdown", "css", "typescript", "javascript" } }),
      -- Spellcheck
      b.code_actions.cspell,
    }

    null_ls.setup({
      sources = sources,
      debug = true,
    })
  end,
}
