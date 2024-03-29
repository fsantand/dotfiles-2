return {
  "mfussenegger/nvim-lint",
  event = "InsertLeave",
  config = function ()
    local lint = require("lint")
    lint.linters_by_ft = {
      markdown = {'vale'},
      javascript = {'eslint_d',},
      typescript = {'eslint_d',},
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
