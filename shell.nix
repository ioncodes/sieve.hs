let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    ghc
    haskell-language-server
    cabal-install
    stack
  ];
}
