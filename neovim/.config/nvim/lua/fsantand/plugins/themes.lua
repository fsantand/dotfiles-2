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
  },
  {
    "loctvl842/monokai-pro.nvim",
    opts = {
      transparent_background = false,
      inc_search = "underline",
    },
    enabled = false,
  },
}
