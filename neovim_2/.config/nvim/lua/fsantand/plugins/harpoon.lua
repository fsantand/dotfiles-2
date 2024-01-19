return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function ()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>aa", function() harpoon:list():append() end, { desc = "Harpoon: add to list" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: open list" })

    vim.keymap.set("n", "<leader>ah", function() harpoon:list():select(1) end, { desc = "Harpoon: Select 1" })
    vim.keymap.set("n", "<leader>aj", function() harpoon:list():select(2) end, { desc = "Harpoon: Select 2" })
    vim.keymap.set("n", "<leader>ak", function() harpoon:list():select(3) end, { desc = "Harpoon: Select 3" })
    vim.keymap.set("n", "<leader>al", function() harpoon:list():select(4) end, { desc = "Harpoon: Select 4" })
  end
}
