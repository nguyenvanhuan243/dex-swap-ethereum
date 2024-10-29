#!/usr/bin/env bash

set -eEo pipefail
# kill -9 $(lsof -t -i :3000) $(lsof -t -i :3001)
# Load NVM
export NVM_DIR="$HOME/.nvm"  # Update this if necessary
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -z "$CLOUD_SHELL" ]; then
  printf "Checking for required yarn version...\n"

  npm install -g yarn > /dev/null 2>&1
  printf "Completed.\n\n"

  printf "Updating Node.js version...\n"
  nvm install 18 || { echo "Failed to install Node.js LTS version."; exit 1; }
  printf "Completed.\n\n"
fi

printf "Installing server dependencies...\n"
cd ./server
yarn install  # Changed to yarn install for consistency
yarn start &
printf "Completed.\n\n"

printf "Installing Frontend...\n"
cd ../dex
yarn install
yarn start
printf "Completed.\n\n"

printf "Setup completed successfully!\n"

if [ -z "$CLOUD_SHELL" ]; then
  printf "\n"
  printf "###############################################################################\n"
  printf "#                                   NOTICE                                    #\n"
  printf "#                                                                             #\n"
  printf "# Make sure you have a compatible Node.js version with the following command:  #\n"
  printf "#                                                                             #\n"
  printf "# nvm install 18                                                              #\n"
  printf "#                                                                             #\n"
  printf "###############################################################################\n"
fi
