return {
  {
    "conform.nvim",
    for_cat = "general",
    auto_enable = true,

    after = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback"
        },
        formatters_by_ft = {
          -- NOTE: download some formatters
          -- and configure them here
          lua = nixInfo(nil, "settings", "cats", "lua") and { "stylua" } or nil,
          cs = { "csharpier" }
          -- go = { "gofmt", "golint" },
          -- templ = { "templ" },
          -- Conform will run multiple formatters sequentially
          -- python = { "isort", "black" },
          -- Use a sub-list to run only the first available formatter
          -- javascript = { { "prettierd", "prettier" } },
        },
      })
    end,
  },
}
