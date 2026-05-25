set shell := ["bash", "-uc"]
set positional-arguments
set dotenv-load

setup:
    rm -f Gemfile.lock
    # Use modern 'nix shell' to fetch tools, then run the bundler commands
    nix shell nixpkgs#bundler nixpkgs#bundix nixpkgs#zlib nixpkgs#libiconv -c bash -c 'bundler update; bundler lock; bundler add jekyll; bundle add webrick; bundler package --no-install --path vendor; BUNDLE_FORCE_RUBY_PLATFORM=true bundix --magic; rm -rf vendor'

serve:
    # Use 'nix develop' to load shell.nix, then execute the server command
    nix develop -f default.nix -c jekyll serve --watch
