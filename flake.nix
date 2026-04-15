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
    in {
      default = pkgs.callPackage ./module.nix {};
      nvim = self.packages.${system}.default;
    });

    overlays.default = final: prev: {
      nvim = self.packages.${final.system}.default;
    };
    overlays.nvim = self.overlays.default;
  };
}
