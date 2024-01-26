{
  description = "Codegen Environment Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    
  };

  outputs = { self, nixpkgs, flake-utils}: 
  flake-utils.lib.eachDefaultSystem (system:
  let pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.default = pkgs.mkShell{ buildInputs = [
      pkgs.rustc
      pkgs.cargo
      pkgs.rustup
      pkgs.flutter
      pkgs.kotlin
      pkgs.ktlint
      pkgs.yarn
      pkgs.protobuf_23
    ];
    shellHook = ''
      rustup  set auto-self-update disable
      rustup toolchain install stable --profile minimal
      yarn global add tslint typescript
      make react-native-codegen
      '';
  };
    
  });
  

}
