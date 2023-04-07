#!/usr/bin/env bash

# The entrypoint script is used to run the application.

# Show a help menu with a list of available commands if the --help flag is passed.
if [[ "$1" == "--help" ]]; then
  echo "Available commands:"
  echo "  start: Start the application."
  echo "  test: Run the test suite."
  echo "  lint: Run the linter."
  echo "  format: Format the code."
  echo "  build: Build the application."
  echo "  clean: Clean the build directory."
  echo "  help: Show this help menu."
  exit 0
fi

# Run the command passed to the entrypoint script.
exec "$@"

# Path: utility-scripts/test.sh
