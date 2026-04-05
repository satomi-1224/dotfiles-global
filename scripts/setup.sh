#!/bin/bash
#
# Full setup script: Nix install → darwin-rebuild switch → extra macOS settings
#
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "=== dotfiles setup ==="
echo "Directory: $DOTFILES_DIR"
echo ""

# -------------------------------------------
# 1. Install Nix (Determinate Installer)
# -------------------------------------------
if command -v nix &> /dev/null; then
  echo "[1/4] Nix is already installed: $(nix --version)"
else
  echo "[1/4] Installing Nix (Determinate Installer)..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

  # Source Nix profile for current session
  if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  fi

  if ! command -v nix &> /dev/null; then
    echo "ERROR: Nix installation failed. Please check the output above."
    echo "You may need to restart your terminal and run this script again."
    exit 1
  fi
  echo "Nix installed: $(nix --version)"
fi

echo ""

# -------------------------------------------
# 2. darwin-rebuild switch
# -------------------------------------------
echo "[2/4] Running darwin-rebuild switch..."
cd "$DOTFILES_DIR"

if command -v darwin-rebuild &> /dev/null; then
  darwin-rebuild switch --flake .
else
  # First time: bootstrap nix-darwin
  nix run nix-darwin -- switch --flake .
fi

echo ""

# -------------------------------------------
# 3. macOS extra settings
# -------------------------------------------
echo "[3/4] Applying macOS extra settings..."
"$DOTFILES_DIR/scripts/setup-macos.sh"

echo ""

# -------------------------------------------
# 4. Secrets setup
# -------------------------------------------
echo "[4/4] Setting up secrets..."
"$DOTFILES_DIR/scripts/setup-secrets.sh"

echo ""
echo "=== Setup complete ==="
echo ""
echo "Next steps:"
echo "  1. Edit ~/.secrets to add your tokens"
echo "  2. Restart your terminal (or run: exec \$SHELL -l)"
echo "  3. Verify: darwin-rebuild switch --flake $DOTFILES_DIR"
