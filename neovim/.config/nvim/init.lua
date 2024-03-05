vim.g.mapleader = " "
vim.o.mouse = ""
vim.o.termguicolors = true
vim.g.maplocalleader = "\\ "
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = ""
vim.o.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = 'menuone,noselect'
vim.cmd([["filetype plugin on"]])

vim.o.undofile = true
vim.o.breakindent = true
vim.wo.signcolumn = "yes"

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ Default ]]
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move to next half page" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move to prev half page" })
vim.keymap.set("n", "<leader>rn", ":set relativenumber!<CR>", { silent = true, desc = "Move to prev half page" })

-- [[ NETRW ]]
vim.keymap.set("n", "-", ":Ex<CR>", { silent=true, desc = "Open file directory" })
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = '\\(^\\|\\s\\s\\)\\zs\\.\\S\\+'

-- [[ Diagnostics ]]
local open_float = function()
  return vim.diagnostic.open_float({ border = "rounded" })
end

local goto_next_diag = function()
  return vim.diagnostic.goto_next({ border = "rounded" })
end

local goto_prev_diag = function()
  return vim.diagnostic.goto_prev({ border = "rounded" })
end

vim.keymap.set("n", "<leader>vd", open_float, { desc = "Open diagnostic" })
vim.keymap.set("n", "]d", goto_next_diag, { desc = "Diagnostics: Go to next" })
vim.keymap.set("n", "[d", goto_prev_diag, { desc = "Diagnostics: Go to previous" })

-- [[ Plugins ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "fsantand.plugins" },
    require("fsantand.plugins.lsp"),
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      }
    }
  },
})
