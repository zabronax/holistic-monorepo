{
  description = "An experiment into holistic monorepo management";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      withSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux" # TODO! NOT Verified
        "x86_64-darwin" # TODO! NOT Verified
        "aarch64-linux" # TODO! NOT Verified
        "aarch64-darwin" # Verified
      ];
      withPkgs = callback: withSystem (system: callback (import nixpkgs { inherit system; }));
    in
    {
      devShells = withPkgs (pkgs: rec {
        default = fullDevShell;

        fullDevShell = pkgs.mkShell {
          packages = with pkgs; [
            # Project management
            sops
            age
          ];
        };
      });

      formatter = withPkgs (pkgs: pkgs.nixfmt-rfc-style);
    };
}
