{
  -- lspconfig hook: applied when the nvim-lspconfig module is being configured.
  lspconfig: (with_cmpcaps) ->
    exists, hook = pcall -> require('vulpecula.hooks.lspconfig')
    if exists
      hook with_cmpcaps

  -- plugins hooks: applied when calling `lazy.setup`. Appends the hook results
  -- to the base plugins list.
  plugins: ->
    base_plugins = require('vulpecula.plugins')

    exists, hook = pcall -> require('vulpecula.hooks.plugins')
    if exists
      return require('vulpecula.utils').merge_tables(base_plugins, hook!)

    return base_plugins
  
  dap: (dapleader) ->
    exists, hook = pcall -> require('vulpecula.hooks.dap')
    if exists
      hook dapleader

  treesitter: ->
    exists, hook = pcall -> require('vulpecula.hooks.treesitter')
    if exists
      return hook!

    return {}
}
