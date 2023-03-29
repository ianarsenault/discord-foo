{
  description = "PrimaMateria neovim flake";

  inputs = { nixpkgs = { url = "github:NixOS/nixpkgs"; }; };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };

      foo = pkgs.stdenv.mkDerivation {
        name = "foo";
        src = ./foo;
        installPhase = ''
          mkdir -p $out/bar
          cp -r bar/. $out/bar/

          find $out/bar -iname "*.sh" -exec chmod a+x {} \;
            
          mkdir -p $out/bin
          cp foo.sh $out/bin/foo
        '';
      };
    in {
      packages.x86_64-linux.default = foo;

      formatter.x86_64-linux =
        inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt;
    };
}
