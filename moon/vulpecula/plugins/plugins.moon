{
  -- COLORSCHEME
  {
    "Shatur/neovim-ayu",
    lazy: false,
    priority: 1000,
    config: ->
      with require 'ayu'
        .setup {}
        .colorscheme!
  },

  -- TELESCOPE
  {
    "nvim-telescope/telescope.nvim"
    dependencies: {
      "nvim-lua/plenary.nvim"
    }
  },

  -- MASON
  {
    "williamboman/mason.nvim"
    lazy: false,
    config: ->
      require('mason').setup {}
  },

  -- LSP
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies: {
      "williamboman/mason.nvim"
    },
    config: ->
      require('mason-lspconfig').setup {automatic_installation: true}
  },
  {
    "neovim/nvim-lspconfig",
    dependencies: {
      "williamboman/mason-lspconfig.nvim"
    },
    config: ->
      require('lspconfig').gopls.setup {}
  },

  -- DAP
  {
    "jayp0521/mason-nvim-dap.nvim",
    dependencies: {
      "williamboman/mason.nvim",
    },
    config: ->
      require('mason-nvim-dap').setup {
        automatic_installation: true,
        ensure_installed: {"delve"}
      }
  },
  {
    "mfussenegger/nvim-dap",
    dependencies: {
      "jayp0521/mason-nvim-dap.nvim"
    }
  },
  {
    "leoluz/nvim-dap-go",
    dependencies: {
      "mfussenegger/nvim-dap",
      "jayp0521/mason-nvim-dap.nvim"
    }
    config: ->
      require('dap-go').setup {}
  },

  -- TREESITTER
  {
    "nvim-treesitter/nvim-treesitter",
    build: ":TSUpdate",
    config: ->
      require('nvim-treesitter.configs').setup {
        ensure_installed: {"go", "query"},
        highlight: {enable: true}
      }
  },
  {
    "nvim-treesitter/playground"
    dependencies: {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  -- GIT
  {
    "tpope/vim-fugitive",
  },

  -- EDITORCONFIG
	"gpanders/editorconfig.nvim",
  
  -- LANGUAGES
  {
    "leafo/moonscript-vim",
    ft: "moon"
  }
}
