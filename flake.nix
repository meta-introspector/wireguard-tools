{
  description = "meta-introspector wireguard-tools fork";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.wireguard-tools.overrideAttrs (old: {
      src = self;
      version = "git-${self.shortRev or "dirty"}";
    });

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [ pkgs.gnumake pkgs.gcc pkgs.pkg-config ];
    };
  };
}
