return {
  {
    "rebelot/kanagawa.nvim",
    opts = {
      inc_search = "underline",
    },
    config = function()
      vim.cmd.colorscheme("kanagawa")
    end,
    priority = 5000,
    enabled = false,
  },
  {
    "loctvl842/monokai-pro.nvim",
    opts = {
      transparent_background = false,
      inc_search = "underline",
    },
    priority = 5000,
    config = function()
      vim.cmd.colorscheme("monokai-pro")
    end,
  },
}
