return {
  "tpope/vim-surround",
  "tpope/vim-fugitive",
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
  { "folke/which-key.nvim",  opts = {} },
  { "numToStr/Comment.nvim", opts = {} },
  {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    command = "DogeGenerate",
  },
}
