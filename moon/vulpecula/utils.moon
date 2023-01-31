{
  merge_tables: (ta, tb) ->
    for i = 1, #tb
      ta[#ta + 1] = tb[i]
    return ta
}
