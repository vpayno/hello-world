# flake.nix
{
  description = "My Hello World Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixOS/nixpkgs/nixos-25.11";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
        "riscv64-linux"
      ];

      imports = [
      ];

      perSystem =
        {
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        let
          a = 1;
        in
        {
          formatter = pkgs.nixfmt;

          packages = {
            default = pkgs.hello;
          };

          devShells = {
            default = pkgs.mkShell {
              name = "default-shell";
              packages = [
                self'.packages.default
              ];
              env = {
                MSG = "Hello World!";
              };
              shellHook = ''
                ${pkgs.lib.getExe pkgs.cowsay} "''${MSG}"
              '';
            };
          };
        };

      # old legacy flake,
      # nixosConfiguration, darwinConfigurations, systemConfigs, homeConfigurations
      flake = {
      };
    };
}
