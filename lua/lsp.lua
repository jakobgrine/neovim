local lsp = require 'lsp-zero'

lsp.preset 'recommended'
lsp.set_preferences {
  sign_icons = {
    -- error = 'E',
    -- warn = 'W',
    -- hint = 'H',
    -- info = 'I'
  }
}

lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set('n', '<Leader>ca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<Leader>cr', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set({'n', 'v'}, '<Leader>cf', function() vim.lsp.buf.format() end, opts)
end)

lsp.setup {}

vim.diagnostic.config {
  virtual_text = true
}
