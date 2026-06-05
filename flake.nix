{
  description = "Linus' configured Neovim";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;
  in {
    packages = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
      neovimPackages =
        (pkgs.lib.evalModules {
          modules = [
            ./module.nix
          ];
        }).packages;
    in {
      default = builtins.elemAt neovimPackages 0;
      nvim = self.packages.${system}.default;
      devnvim = builtins.elemAt neovimPackages 1;
    });

    overlays.default = final: prev: {
      nvim = self.packages.${final.system}.default;
      devnvim = self.packages.${final.system}.devnvim;
    };
    overlays.nvim = self.overlays.default;
  };
}
