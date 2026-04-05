#!/bin/bash
set -euo pipefail

SECRETS_FILE="$HOME/.secrets"

if [ -f "$SECRETS_FILE" ]; then
  echo "$SECRETS_FILE already exists. Skipping."
  exit 0
fi

cat > "$SECRETS_FILE" << 'TEMPLATE'
# Machine-specific secrets (this file is NOT managed by Git)
#
# Add your tokens and secrets below.
# This file is sourced by zsh on startup.
#
# Example:
# export GITHUB_TOKEN="ghp_xxx"
# export ASANA_API_TOKEN="xxx"
TEMPLATE

chmod 600 "$SECRETS_FILE"
echo "Created $SECRETS_FILE (chmod 600)"
echo "Edit it to add your tokens: \$EDITOR $SECRETS_FILE"
