with import <nixpkgs> {};
mkShell {
  buildInputs = [ nim openblas ];
}
