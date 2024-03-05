return {
  "andweeb/presence.nvim",
  event = "VeryLazy",
  config = function ()
    require('presence').setup({
      auto_update = true,
    });
  end
}
