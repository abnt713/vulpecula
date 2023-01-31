{
  -- lspconfig hook: applied when the nvim-lspconfig module is being configured.
  lspconfig: (with_cmpcaps) ->
    pcall ->
      require('vulpecula.hooks.lspconfig')(with_cmpcaps)
}
