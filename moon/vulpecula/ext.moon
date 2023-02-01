{
  -- editor hook: applied when booting the editor.
  editor: ->
    exists, hook = pcall -> require('hooks.editor')
    if exists
      hook!

  -- lspconfig hook: applied when the nvim-lspconfig module is being configured.
  lspconfig: (with_cmpcaps) ->
    exists, hook = pcall -> require('hooks.lspconfig')
    if exists
      hook with_cmpcaps

  -- lazy hook: applied when calling `lazy.setup`. Appends the hook results
  -- to the base plugins list.
  lazy: ->
    base_plugins = require('vulpecula.plugins')

    exists, hook = pcall -> require('hooks.lazy')
    if exists
      hook_content = hook!
      return require('vulpecula.utils').merge_tables(base_plugins, hook_content)

    return base_plugins
  
  dap: (dapleader) ->
    exists, hook = pcall -> require('hooks.dap')
    if exists
      hook dapleader

  treesitter: ->
    exists, hook = pcall -> require('hooks.treesitter')
    if exists
      return hook!

    return {}
  
  null_ls: ->
    exists, hook = pcall -> require('hooks.null_ls')
    if exists
      return hook!

    return {}
}
