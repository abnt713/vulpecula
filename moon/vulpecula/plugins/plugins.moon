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
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp"
    },
    config: ->
      cmpcaps = require('cmp_nvim_lsp').default_capabilities!
      applycaps = (settings) ->
        settings["capabilities"] = cmpcaps
        return settings

      require('lspconfig').gopls.setup applycaps({})
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

  -- AUTOCOMPLETE
  {
    "hrsh7th/nvim-cmp",
    dependencies: {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip"
    }
    config: ->
      vim.o.completeopt = 'menu,menuone,noselect'
      with cmp = require 'cmp'
        .setup {
          snippet: {
            expand: (args) ->
              vim.fn["vsnip#anonymous"] args.body
          },
          window: {
            completion: cmp.config.window.bordered!,
            documentation: cmp.config.window.bordered!
          },
          mapping: {
            ['<CR>']: cmp.mapping.confirm { select: true },
            ['<C-Space>']: cmp.mapping(cmp.mapping.complete!, { 'i', 'c' }),
            ['<Tab>']: cmp.mapping(((fallback) ->
              if cmp.visible!
                cmp.select_next_item!
                return
              fallback!
            ), { 'i', 's' }),
            ['<S-Tab>']: cmp.mapping(((fallback) ->
              if cmp.visible!
                cmp.select_prev_item!
                return
              fallback!
            ), { 'i', 's' }),
          },
          sources: cmp.config.sources {
            {name: 'nvim_lsp'},
            {name: 'vsnip'}
          }, {
            {name: 'buffer'}
          }
        }
        .setup.cmdline({'/', '?'}, {
          mapping: cmp.mapping.preset.cmdline!,
          sources: {
            {name: 'buffer'}
          }
        })
        .setup.cmdline(':', {
          mapping: cmp.mapping.preset.cmdline!,
          sources: cmp.config.sources {
            {{name: 'path'}},
            {{name: 'cmdline', option: {ignore_cmds: {'Man', '!'}}}}
          }
        })
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
