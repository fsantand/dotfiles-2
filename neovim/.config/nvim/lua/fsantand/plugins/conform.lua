return {
  "stevearc/conform.nvim",
  event = "LspAttach",
  config = function ()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" }
      }
    })

    vim.api.nvim_create_user_command("Conform", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })

    vim.keymap.set("n", "<leader>fm", ":Conform<CR>", { silent = true, desc = "Conform: format document" })
  end,
}
