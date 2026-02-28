return {
  {
    "trouble.nvim",
    for_cat = "general",
    auto_enable = true,
    after = function()
      require('trouble').setup()
    end
  }
}
