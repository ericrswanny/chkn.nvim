#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define the path to Plenary
PLENARY_PATH="${HOME}/.local/share/nvim/site/pack/plugins/start/plenary.nvim"

# Check if Plenary is installed, and clone it if not
if [ ! -d "${PLENARY_PATH}" ]; then
  echo "Plenary not found. Cloning it now..."
  mkdir -p "$(dirname "${PLENARY_PATH}")"
  git clone --depth 1 https://github.com/nvim-lua/plenary.nvim "${PLENARY_PATH}"
  echo "Plenary cloned to ${PLENARY_PATH}"
fi

# Run Plenary tests
nvim --headless -c "lua require('plenary.test_harness').test_directory('tests', { minimal_init = './tests/init.lua' })"

echo "Tests passed successfully!"
