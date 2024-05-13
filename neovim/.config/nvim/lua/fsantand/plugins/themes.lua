return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    opts = {
      inc_search = "underline",
    },
    priority = 5000,
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    opts = {
      transparent_background = false,
      inc_search = "underline",
      filter = "machine",
    },
    priority = 5000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd[[colorscheme tokyonight]]
    end
  }
}
