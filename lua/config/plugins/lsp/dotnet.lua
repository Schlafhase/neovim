return {
  {
    "easy-dotnet.nvim",
    auto_enable = true,
    for_cat = "dotnet",
    ft = { "cs", "fs", "vb", "sln", "csproj", "fsproj" },
    after = function()
      require('easy-dotnet').setup()
    end
  },
}
