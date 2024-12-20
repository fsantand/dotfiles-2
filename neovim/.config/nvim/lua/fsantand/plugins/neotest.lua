return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "adrigzr/neotest-mocha",
    "rouge8/neotest-rust",
    'nvim-neotest/nvim-nio',
  },
  event = "LspAttach",
  config = function ()
    require("neotest").setup({
      adapters = {
        require("neotest-mocha")({
          command = "npm test --",
          env = { CI = true },
          cwd = function(_)
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-rust"),
      },
    })
  end
}
