{
	bootstrap: ->
		lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
		if not vim.loop.fs_stat(lazypath)
			print 'Lazy.nvim not found. Installing...'
			vim.fn.system {
				"git",
				"clone",
				"--filter=blob:none",
				"https://github.com/folke/lazy.nvim.git",
				"--branch=stable", -- latest stable release
				lazypath,
			}
		vim.opt.rtp\prepend(lazypath)
	setup: ->
		require("lazy").setup(require('vulpecula.plugins.plugins'))
}
