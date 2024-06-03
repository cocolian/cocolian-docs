#!/bin/bash

cmd="cd /home/cocolian/cocolian/cocolian-docs;" 
cmd="$cmd  git  pull; "
cmd="$cmd  pkill ruby;"
cmd="$cmd  pkill run.sh;"
cmd="$cmd  bundle exec jekyll  build;"
cmd="$cmd  chmod u+x run.sh;"
ssh aliserver "$cmd" 
echo "execute‘ $cmd  ’on remote server !" 
ssh aliserver " nohup /home/cocolian/cocolian/cocolian-docs/run.sh &"