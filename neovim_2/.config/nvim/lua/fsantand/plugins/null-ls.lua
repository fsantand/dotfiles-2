return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  config = function()
    local null_ls = require 'null-ls'
    local b = null_ls.builtins

    local source = {
      b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "typescript", "javascript" } },
      -- Lua
      b.formatting.stylua,
      -- Spellcheck
      b.diagnostics.cspell,
      b.code_actions.cspell,
    }

    null_ls.setup {
      source = source,
    }
  end,
}
