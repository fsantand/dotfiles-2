return {
  "mfussenegger/nvim-lint",
  config = function ()
    local lint = require("lint")
    lint.linters_by_ft = {
      markdown = {'vale',},
      javascript = {'eslint',},
      typescript = {'eslint',},
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
