vim.opt.termguicolors = true

vim.g.gruvbox_italic = true
vim.cmd 'colorscheme gruvbox'

local transparent_groups = {
  Normal = {},
  Conceal = {},
  VertSplit = {},
  SignColumn = {},
  FloatTitle = {},
  NormalFloat = {},
}
for g, o in pairs(transparent_groups) do
  vim.cmd(string.format('hi %s guibg=NONE %s', g, table.concat(o, ' ')))
end
