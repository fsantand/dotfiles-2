local M = {}

function M.on_attach(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>ra", vim.lsp.buf.rename, "[R]en[a]me")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [a]ctions")

  nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  vim.keymap.set("i", "<C-S-h>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })
end

return M
