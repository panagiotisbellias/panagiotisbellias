#!/usr/bin/env bash
set -e

echo "## GENERAL ##"

# GitHub CLI
if command -v gh &>/dev/null; then
  echo "gh-$(gh --version | head -n1 | awk '{print $3}')"
else
  echo "gh-not-installed"
fi

# Gnome Keyring
if command -v gnome-keyring-daemon &>/dev/null; then
  echo "gnome-keyring-$(gnome-keyring-daemon --version 2>/dev/null || echo unknown)"
else
  echo "gnome-keyring-not-installed"
fi

# TODO Add here any new general tools

# Devbox
if command -v devbox &>/dev/null; then
  if devbox version &>/dev/null; then
    echo "devbox-$(devbox version | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')"
  elif devbox --help | grep -qi devbox; then
    echo "devbox-$(devbox --help | head -n 1 | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')"
  else
    echo "devbox-installed-but-version-unknown"
  fi
else
  echo "devbox-not-installed"
fi

# Nix
if command -v nix &>/dev/null; then
  echo "nix-$(nix --version | awk '{print $3}')"
else
  echo "nix-not-installed"
fi

echo ""
echo "## STACK ##"

echo "# Nixopus #"
if command -v go &>/dev/null; then
  echo "go-$(go version | awk '{print $3}')"
else
  echo "go-not-installed"
fi

if command -v psql &>/dev/null; then
  echo "psql-$(psql --version | awk '{print $3}')"
else
  echo "psql-not-installed"
fi
