#!/bin/bash

\. "$HOME/.nvm/nvm.sh"

nvm install 18

cd /server
npm init -y
npm i express

exec node index.js


