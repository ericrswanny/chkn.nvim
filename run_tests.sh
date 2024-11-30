#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure plenary is installed (optional check)
if [ ! -d "${HOME}/.local/share/nvim/lazy/plenary.nvim" ]; then
  echo "Plenary is not installed. Please install it using your plugin manager."
  exit 1
fi

# Run Plenary tests
nvim --headless -c "PlenaryBustedDirectory tests/ { minimal_init = './tests/init.lua' }" || exit 1

echo "Tests passed successfully!"
