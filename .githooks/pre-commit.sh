#!/bin/bash

# Run your script
ruby ./assets/scripts/generate_map_export.rb

# Exit with status code 0 to proceed with the commit, or non-zero to abort
if [ $? -ne 0 ]; then
  echo "The csv generator script failed. Commit aborted."
  exit 1
fi

# Allow the commit to proceed
echo "The csv generator script ran."
exit 0
