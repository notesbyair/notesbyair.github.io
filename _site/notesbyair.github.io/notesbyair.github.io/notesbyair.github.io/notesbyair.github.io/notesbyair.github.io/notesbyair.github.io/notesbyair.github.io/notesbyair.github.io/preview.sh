#!/bin/bash
rsync -avu  "/home/deepflow/Desktop/Parallels Shared Folders/Dropbox/notesbyair/assets/" assets/
rsync -avu --delete "/home/deepflow/Desktop/Parallels Shared Folders/Dropbox/notesbyair/_posts/" _posts/

bundle exec jekyll serve --port 4001 --watch
