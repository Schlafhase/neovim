inputs: {
  config,
  wlib,
  lib,
  pkgs,
  ...
}: {
  imports = [wlib.wrapperModules.neovim];
  # NOTE: see the tips and tricks section or the bottom of this file + flake inputs to understand this value
  options.nvim-lib.neovimPlugins = lib.mkOption {
    readOnly = true;
    type = lib.types.attrsOf wlib.types.stringable;
    # Makes plugins autobuilt from our inputs available with
    # `config.nvim-lib.neovimPlugins.<name_without_prefix>`
    default = config.nvim-lib.pluginsFromPrefix "plugins-" inputs;
  };

  # choose a directory for your config.
  config = {
    settings.config_directory = ./.;
    settings.colorscheme = "moonfly";
    specs = {
      colorscheme = {
        lazy = true;
        data = builtins.getAttr config.settings.colorscheme (
          with pkgs.vimPlugins; {
            "onedark_dark" = onedarkpro-nvim;
            "onedark_vivid" = onedarkpro-nvim;
            "onedark" = onedarkpro-nvim;
            "onelight" = onedarkpro-nvim;
            "moonfly" = vim-moonfly-colors;
            "catppuccin" = catppuccin-nvim;
          }
        );
      };
      lze = [
        # if defaults is fine, you can just provide the `.data` field
        config.nvim-lib.neovimPlugins.lze
        # but these can be specs too!
        {
          # these ones can't take lists though
          data = config.nvim-lib.neovimPlugins.lzextras;
          # things can target any spec that has a name.
          name = "lzextras";
          # now something else can be after = [ "lzextras" ]
          # the spec name is not the plugin name.
          # to override the plugin name, use `pname`
          # You could run something before your main init.lua like this
          # before = [ "INIT_MAIN" ];
          # You can include configuration and translated nix values here as well!
          # type = "lua"; # | "fnl" | "vim"
          # info = { };
          # config = ''
          #   local info, pname, lazy = ...
          # '';
        }
      ];
      ui = {
        data = with pkgs.vimPlugins; [
          smear-cursor-nvim
          noice-nvim
        ];
      };
      nix = {
        data = null;
        extraPackages = with pkgs; [
          alejandra
        ];
      };
      lua = {
        after = ["general"];
        lazy = true;
        data = with pkgs.vimPlugins; [
          lazydev-nvim
        ];
        extraPackages = with pkgs; [
          lua-language-server
          stylua
        ];
      };
      dotnet = {
        after = ["general"];
        lazy = true;
        data = with pkgs.vimPlugins; [
          # easy-dotnet-nvim
        ];
        extraPackages = with pkgs; [
          csharpier
          roslyn-ls
          dotnetCorePackages.sdk_10_0
          dotnet-ef
          (writeShellScriptBin "roslyn" "Microsoft.CodeAnalysis.LanguageServer")
          (buildDotnetGlobalTool {
            pname = "dotnet-easydotnet";
            nugetName = "easydotnet";
            version = "2.3.63";
            nugetHash = "sha256-8ywDdEWxDZUtggvY/2d4Revk09+qb3llymru0Ptpp5c=";
            dotnet-sdk = pkgs.dotnet-sdk;
          })
        ];
      };
      go = {
        after = ["general"];
        lazy = true;
        data = with pkgs.vimPlugins; [
          go-nvim
        ];
        extraPackages = with pkgs; [
          gopls
        ];
      };
      haskell = {
        after = ["general"];
        lazy = true;
        data = with pkgs.vimPlugins; [
          haskell-tools-nvim
        ];
        extraPackages = with pkgs.haskellPackages; [
          haskell-language-server
          ghc
        ];
      };
      general = {
        # this would ensure any config included from nix in here will be ran after any provided by the `lze` spec
        # If we provided any from within either spec, anyway
        after = ["lze"];
        # note we didn't have to specify the `lze` specs name, because it was a top level spec
        extraPackages = with pkgs; [
          tree-sitter
        ];
        # this `lazy = true` definition will transfer to specs in the contained DAL, if there is one.
        # This is because the definition of lazy in `config.specMods` checks `parentSpec.lazy or false`
        # the submodule type for `config.specMods` gets `parentSpec` as a `specialArg`.
        # you can define options like this too!
        lazy = true;
        # here we chose a DAL of plugins, but we can also pass a single plugin, or null
        # plugins are of type wlib.types.stringable
        data = let
          rainbow-delimiters-nvim-newest = pkgs.vimUtils.buildVimPlugin {
            name = "rainbow-delimiters-nvim";
            src = pkgs.fetchFromGitHub {
              owner = "HiPhish";
              repo = "rainbow-delimiters.nvim";
              rev = "b81d594e82b6ca1530797bdcfd16a1219250a2d8";
              hash = "sha256-q4cBvF8d5h+BM1LTm5aq02OBVmwSUb9rC1smHlxbRzg=";
            };

            nvimSkipModules = [
              "rainbow-delimiters.types"
              "rainbow-delimiters._test.highlight"
            ];
          };

          easy-dotnet-newest = pkgs.vimUtils.buildVimPlugin {
            name = "easy-dotnet.nvim";
            src = pkgs.fetchFromGitHub {
              owner = "GustavEikaas";
              repo = "easy-dotnet.nvim";
              rev = "f945f63911cee52f3bfc5036006d74745c273c20";
              hash = "sha256-TOmriG98U8D9GZek2S+eXFTqrd+yRrufuRQK898SAUA=";
            };

            nvimSkipModules = [
              "easy-dotnet.picker._telescope"
              "easy-dotnet.roslyn.lsp"
              "easy-dotnet.roslyn.root_finder"
            ];
          };

          image = pkgs.vimUtils.buildVimPlugin {
            name = "image.nvim";
            src = pkgs.fetchFromGitHub {
              owner = "3rd";
              repo = "image.nvim";
              rev = "da2be65c153ba15a14a342b05591652a6df70d58";
              hash = "sha256-brDtVYD3O+7N2RdQPIx2+6P+faXafoJDUITy0z0cIuA=";
            };

            nvimSkipModules = [
              "minimal-setup"
            ];
          };
        in
          with pkgs.vimPlugins; [
            {
              data = vim-sleuth;
              # You can override defaults from the parent spec here
              lazy = false;
            }
            snacks-nvim
            nvim-lspconfig
            nvim-surround
            vim-startuptime
            blink-cmp
            blink-compat
            cmp-cmdline
            colorful-menu-nvim
            lualine-nvim
            gitsigns-nvim
            which-key-nvim
            fidget-nvim
            nvim-lint
            conform-nvim
            nvim-treesitter-textobjects
            # treesitter + grammars
            nvim-treesitter.withAllGrammars
            # This is for if you only want some of the grammars
            # (nvim-treesitter.withPlugins (
            #   plugins: with plugins; [
            #     nix
            #     lua
            #   ]
            # ))
            vim-illuminate
            mini-icons
            trouble-nvim
            telescope-nvim
            nvim-notify
            markview-nvim
            moveline-nvim
            persistence-nvim
            rainbow-delimiters-nvim-newest
            nvim-autopairs
            flash-nvim
            nvim-treesitter-context
            bufferline-nvim
            nvim-highlight-colors
            nvim-web-devicons
            easy-dotnet-newest
            todo-comments-nvim
            dropbar-nvim
            image
          ];
      };
    };
    specMods = {
      # When this module is ran in an inner list,
      # this will contain `config` of the parent spec
      parentSpec ? null,
      # and this will contain `options`
      # otherwise they will be `null`
      parentOpts ? null,
      parentName ? null,
      # and then config from this one, as normal
      config,
      # and the other module arguments.
      ...
    }: {
      # you could use this to change defaults for the specs
      # config.collateGrammars = lib.mkDefault (parentSpec.collateGrammars or false);
      # config.autoconfig = lib.mkDefault (parentSpec.autoconfig or false);
      # config.runtimeDeps = lib.mkDefault (parentSpec.runtimeDeps or false);
      # config.pluginDeps = lib.mkDefault (parentSpec.pluginDeps or false);
      # or something more interesting like:
      # add an extraPackages field to the specs themselves
      options.extraPackages = lib.mkOption {
        type = lib.types.listOf wlib.types.stringable;
        default = [];
        description = "a extraPackages spec field to put packages to suffix to the PATH";
      };
      # You could do this too
      # config.before = lib.mkDefault [ "INIT_MAIN" ];
    };
    extraPackages = config.specCollect (acc: v: acc ++ (v.extraPackages or [])) [];
  };

  # Inform our lua of which top level specs are enabled
  options.settings.cats = lib.mkOption {
    readOnly = true;
    type = lib.types.attrsOf lib.types.bool;
    default = builtins.mapAttrs (_: v: v.enable) config.specs;
  };
  # build plugins from inputs set
  options.nvim-lib.pluginsFromPrefix = lib.mkOption {
    type = lib.types.raw;
    readOnly = true;
    default = prefix: inputs:
      lib.pipe inputs [
        builtins.attrNames
        (builtins.filter (s: lib.hasPrefix prefix s))
        (map (
          input: let
            name = lib.removePrefix prefix input;
          in {
            inherit name;
            value = config.nvim-lib.mkPlugin name inputs.${input};
          }
        ))
        builtins.listToAttrs
      ];
  };
}
