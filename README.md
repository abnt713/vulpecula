# Vulpecula.nvim

> You become responsible, forever, for what you have tamed.

Vulpecula is a simple neovim config - and also the 
[Fox Constelation](https://en.wikipedia.org/wiki/Vulpecula). It aims to expose 
hooks as points of customization. As of now, these are the hooks available 
for customization:

- Editor configs, variables and settings.
- [Lazy](https://github.com/folke/lazy.nvim) plugins.
- [Nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) servers.
- [Nvim-dap](https://github.com/mfussenegger/nvim-dap) adapters.
- [Null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) sources.
- [Nvim-Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) setup opts.

By using [Mason](https://github.com/williamboman/mason.nvim), Vulpecula can
install dependencies automatically. It is only required to add the module
configuration to the corresponding hook:

```moonscript
-- moon/hooks/lspconfig.moon
(with_cmpcaps) ->
  -- Configuring gopls as an example. Vulpecula will automatically install it.
  require('lspconfig').gopls.setup with_cmpcaps({})
```

## Requirements

- [Mason Requirements](https://github.com/williamboman/mason.nvim#requirements)
- [Treesitter Requirements](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
- [Moonscript](https://moonscript.org/)
- [Make](https://www.gnu.org/software/make/)
- [Nerd Font](https://www.nerdfonts.com/)

**Note**: This project was built entirely on Linux, untested on Windows.

## Getting Started

1. (Optional) Backup any existing neovim config.
1. Clone this repository in the neovim config path.
	- Usually it's `$XDG_CONFIG_DIR/nvim`
	- You can check it from neovim by typing `:echo stdpath('config')`
1. Run `make hooks`
1. Run `make`
1. Start neovim and let it install the dependencies.

Now you can edit the hook files located in `moon/hooks/*.moon` to add 
LSP servers, DAP adapters and so on.
