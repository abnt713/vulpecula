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
    lazy: false,
    dependencies: {
      "williamboman/mason.nvim"
    },
    config: ->
      require('mason-lspconfig').setup {automatic_installation: true}
  },
  {
    "neovim/nvim-lspconfig",
    lazy: false,
    dependencies: {
      "williamboman/mason-lspconfig.nvim"
    },
    config: ->
      require('lspconfig').gopls.setup {}
  },

  -- DAP
  {
    "jayp0521/mason-nvim-dap.nvim",
    lazy: false,
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
    lazy: false,
    dependencies: {
      "jayp0521/mason-nvim-dap.nvim"
    }
  },
  {
    "leoluz/nvim-dap-go",
    lazy: false,
    dependencies: {
      "mfussenegger/nvim-dap",
      "jayp0521/mason-nvim-dap.nvim"
    }
    config: ->
      require('dap-go').setup {}
  },

  -- GIT
  {
    "tpope/vim-fugitive",
    lazy: false
  },

  -- EDITORCONFIG
	"gpanders/editorconfig.nvim",
  
  -- LANGUAGES
  {
    "leafo/moonscript-vim",
    ft: "moon"
  }
}
