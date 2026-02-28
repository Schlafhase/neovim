return {
  {
    "nvim-surround",
    auto_enable = true,
    event = "DeferredUIEnter",
    lazy = true,
    -- keys = "",
    after = function(plugin)
      require("nvim-surround").setup()
    end,
  },
}
