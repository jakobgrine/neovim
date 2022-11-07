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
  local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

require 'packer'.startup(function()
  use 'wbthomason/packer.nvim'

  use {'morhetz/gruvbox', config = function() require 'colorscheme' end}

  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sleuth'
  use {'tpope/vim-commentary', keys = {'gc', 'gcc', 'gcu'}}
  use {'tpope/vim-vinegar', keys = '-'}
  use {'tpope/vim-dispatch', cmd = {'Make', 'Dispatch', 'Start', 'Spawn'}}
  use 'dhruvasagar/vim-table-mode'
  use 'ap/vim-css-color'

  use {
    'lervag/vimtex',
    ft = 'tex',
    config = function()
      -- vim.keymap.set('n', '<Leader>cc', '<Cmd>w<CR> <Plug>(vimtex-compile-ss)')
      -- vim.keymap.set('n', '<Leader>mc', '<Cmd>w<CR> <Plug>(vimtex-compile)')
    end
  }

  use {
    'williamboman/mason.nvim',
    config = function()
      require 'mason'.setup {}
    end
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require 'mason-lspconfig'.setup {
        automatic_installation = true
      }
    end
  }
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require 'lsp'
    end
  }
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'trouble'.setup {
        auto_open = true,
        auto_close = true
      }
    end
  }

  if packer_bootstrap then
    require 'packer'.sync()
  end
end)
