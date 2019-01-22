#!/bin/bash
JEKYLL_ENV=production bundle exec jekyll build
rsync -avu _site/ notesbyair.github.io/
cd notesbyair.github.io/
git add .
read -p "enter commit message " msg
git commit -m "$msg"
git push


