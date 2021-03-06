#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
 echo "Installing homebrew..."
 ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade
brew upgrade --cask

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install other stuff
brew bundle install

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
ln -s -f "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Set python to python3
ln -s -f /usr/local/bin/python3 /usr/local/bin/python

# Remove outdated versions from the cellar.
brew cleanup
brew cleanup --prune-prefix

# check if more is installed than it should
brew bundle cleanup
