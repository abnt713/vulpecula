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
