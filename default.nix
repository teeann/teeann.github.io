with (import <nixpkgs> { });
let
  env = bundlerEnv {
    name = "jekyll-blog-env";
    inherit ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in stdenv.mkDerivation {
  name = "jekyll-blog-shell";
  # Added zlib and libiconv here so they are always available to native extensions
  buildInputs = [ env ruby zlib libiconv ]; 
}
