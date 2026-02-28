return {
  {
    "fidget.nvim",
    auto_enable = true,
    event = "DeferredUIEnter",
    -- keys = "",
    after = function(plugin)
      require("fidget").setup({})
    end,
  },
}
