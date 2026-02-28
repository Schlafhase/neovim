return {
  {
    "mason.nvim",
    enabled = not nixInfo.isNix,
    priority = 100, -- <- run lsp hook before lspconfig's hook
    on_plugin = { "nvim-lspconfig" },
    lsp = function(plugin)
      vim.cmd.MasonInstall(plugin.name)
    end,
  },
}
