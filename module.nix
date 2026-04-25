{
  pkgs,
  lib,
  ...
}: let
  extraPackages = with pkgs; [
    tree-sitter

    roslyn-ls
    dotnetCorePackages.sdk_10_0
    dotnet-ef
    netcoredbg
    csharpier
    (writeShellScriptBin "roslyn" "Microsoft.CodeAnalysis.LanguageServer")
    (buildDotnetGlobalTool {
      pname = "dotnet-easydotnet";
      nugetName = "easydotnet";
      version = "3.0.33";
      nugetHash = "sha256-owjlIzwsYr6gNBpZawtyK4EY6xvKRgcvQ8dxkTRwXIY=";
      dotnet-sdk = pkgs.dotnet-sdk;
    })

    alejandra
    nixd

    lua-language-server
    stylua
    prettier

    go
    gopls

    haskell-language-server
    ghc

    (python3.withPackages (python-pkgs: [
      python-pkgs.numpy
      python-pkgs.debugpy
    ]))
    pyright
    black
    python312Packages.debugpy
  ];

  configDir = pkgs.stdenv.mkDerivation {
    name = "nvim-config";
    src = ./.;
    installPhase = ''
      mkdir -p $out
      cp -r ./* $out
    '';
  };
in
  pkgs.symlinkJoin {
    name = "nvim";
    paths = [pkgs.neovim-unwrapped];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/nvim \
        --set VIMINIT "lua dofile('${configDir}/init.lua')" \
        --add-flags '--cmd' \
        --add-flags "'set runtimepath^=${configDir}'" \
        --prefix PATH : ${lib.makeBinPath extraPackages} \
        --set NVIM_APPNAME nvim-linus
    '';
  }
