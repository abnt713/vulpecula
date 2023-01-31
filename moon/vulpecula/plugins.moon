keymap = vim.api.nvim_set_keymap
default_opts = { noremap: true, silent: true }

-- All plugins definitions
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
      "nvim-lua/plenary.nvim",
    },
    config: ->
      require('telescope').setup {}
      keymap('n', '<Leader>ff', "<cmd>Telescope find_files<CR>", default_opts)
      keymap('n', '<Leader>fg', "<cmd>Telescope live_grep<CR>", default_opts)
      keymap('n', '<Leader>fb', "<cmd>Telescope buffers<CR>", default_opts)
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
      with_cmpcaps = (settings) ->
        settings["capabilities"] = cmpcaps
        return settings

      require('vulpecula.hook').lspconfig with_cmpcaps

      keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>', default_opts)
      keymap('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()', default_opts)
      keymap('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()', default_opts)
  },
  {
    "ojroques/nvim-lspfuzzy",
    dependencies: {
      "junegunn/fzf",
      "junegunn/fzf.vim"
    },
    config: ->
      require('lspfuzzy').setup {}
  },
  {
    "glepnir/lspsaga.nvim",
    event: "BufRead",
    dependencies: {
      "neovim/nvim-lspconfig",
      "nvim-tree/nvim-web-devicons"
    },
    config: ->
      require("lspsaga").setup {}

      keymap('n', 'ga', '<cmd>Lspsaga code_action<CR>', default_opts)
      keymap('n', 'gh', '<cmd>Lspsaga hover_doc<CR>', default_opts)
      keymap('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', default_opts)
      keymap('n', 'gm', '<cmd>Lspsaga rename ++project<CR>', default_opts)
      keymap('n', 'gM', '<cmd>Lspsaga rename<CR>', default_opts)
      keymap('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>', default_opts)
  }

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
      "jayp0521/mason-nvim-dap.nvim",
      "jbyuki/one-small-step-for-vimkind"
    }
    config: ->
      dap = require('dap')
      dap.adapters.nlua = (callback, config) ->
        callback {
          type: 'server',
          host: config.host or "127.0.0.1",
          port: config.port or 8086
        }
      dap.configurations.lua = {
        {
          type: 'nlua',
          request: 'attach',
          name: "nlua attach",
          host: '127.0.0.1',
          port: ->
            tonumber vim.fn.input('Port: ')
        }
      }

      dapleader = "\\"
      keymap("n", "#{dapleader}c", "<cmd>lua require('dap').continue()<CR>", default_opts)
      keymap("n", "#{dapleader}r", "<cmd>lua require('dap').repl.toggle()<CR>", default_opts)
      keymap("n", "#{dapleader}b", "<cmd>lua require('dap').toggle_breakpoint()<CR>", default_opts)
      keymap("n", "#{dapleader}l", "<cmd>lua require('dap').list_breakpoints(true)<CR>", default_opts)
      keymap("n", "#{dapleader}<s-b>", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", default_opts)

      keymap('n', "#{dapleader}h", "<cmd>lua require('dap.ui.widgets').hover()<CR>", default_opts)
      keymap('n', '<F5>', '<cmd>lua require("osv").launch({port = 8086})<CR>', default_opts)
  },

  -- TREESITTER
  {
    "nvim-treesitter/nvim-treesitter",
    build: ":TSUpdate",
    config: ->
      require('nvim-treesitter.configs').setup {
        ensure_installed: {"go", "query", "markdown"},
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
      "hrsh7th/cmp-nvim-lsp-signature-help",
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
            {name: 'nvim_lsp_signature_help'},
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

  -- LINTER
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies: {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim"
    },
    config: ->
      require('mason-null-ls').setup {
        automatic_installation: true
      }
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies: {
      "glepnir/lspsaga.nvim",
      "nvim-lua/plenary.nvim"
    },
    config: ->
      with null_ls = require('null-ls')
        .setup {
          sources: {
            null_ls.builtins.diagnostics.revive,
            null_ls.builtins.formatting.goimports,
            null_ls.builtins.formatting.gofumpt
          },
        }
  },

  -- Utilities
  {
    "tpope/vim-fugitive",
    config: ->
      keymap('n', '<Leader>gs', '<cmd>:Git<CR>', default_opts)
      keymap('n', '<Leader>gc', '<cmd>:Git commit<CR>', default_opts)
      keymap('n', '<Leader>gb', '<cmd>:Git commit<CR>', default_opts)
  },
  {
    "airblade/vim-gitgutter",
    config: ->
      keymap('n', '<Leader>gp', '<cmd>GitGutterPrevHunk<CR>', default_opts)
      keymap('n', '<Leader>gn', '<cmd>GitGutterNextHunk<CR>', default_opts)
  },
	"gpanders/editorconfig.nvim",
  "chrisbra/colorizer",
  "tpope/vim-commentary",
  {
    "lukas-reineke/indent-blankline.nvim",
    config: ->
      vim.g.indentLine_fileTypeExclude = {
        'checkhealth', 'help', 'lspinfo', 'packer', 'startup'
      }
      require('indent_blankline').setup {
        char: '¦',
        buftype_exclude: {'terminal'}
      }
  }
  
  -- LANGUAGES
  {
    "leafo/moonscript-vim",
    ft: "moon"
  }
}
