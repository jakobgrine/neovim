vim.opt.undofile = true
vim.opt.ignorecase = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2

vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Leader>fs', '<Cmd>w<CR>')

local ensure_packer = function()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

require 'packer'.startup(function()
  use 'wbthomason/packer.nvim'

  use { 'morhetz/gruvbox', config = function() require 'colorscheme' end }

  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sleuth'
  use { 'tpope/vim-commentary', keys = { 'gc', 'gcc', 'gcu' } }
  use { 'tpope/vim-vinegar', keys = '-' }
  use { 'tpope/vim-dispatch', cmd = { 'Make', 'Dispatch', 'Start', 'Spawn' } }
  use 'dhruvasagar/vim-table-mode'
  use 'ap/vim-css-color'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'nvim-tree'.setup {
        on_attach = function(bufnr)
          local api = require 'nvim-tree.api'
          api.config.mappings.default_on_attach(bufnr)

          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
          vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
        end
      }

      vim.keymap.set('n', '<Leader>ft', '<Cmd>NvimTreeFocus<CR>')
    end,
  }

  use {
    'lervag/vimtex',
    ft = 'tex',
    config = function()
      -- vim.keymap.set('n', '<Leader>cc', '<Cmd>w<CR> <Plug>(vimtex-compile-ss)')
      -- vim.keymap.set('n', '<Leader>mc', '<Cmd>w<CR> <Plug>(vimtex-compile)')
    end
  }
  use {
    'preservim/vim-markdown',
    ft = { 'md', 'markdown' },
    config = function()
      vim.g.vim_markdown_math = 1
      vim.opt.conceallevel = 2
      vim.g.vim_markdown_frontmatter = 1
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'treesitter'
    end
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Completion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets'
    },
    config = function()
      require 'lsp'
    end
  }
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'trouble'.setup {}
    end
  }
  use {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = function()
      require 'fidget'.setup {}
    end,
  }

  if packer_bootstrap then
    require 'packer'.sync()
  end
end)
