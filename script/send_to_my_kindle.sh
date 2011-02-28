#!/bin/bash

if [ -d /opt/calibre/resources/recipes ]; then
    CALIBRE_RECIPE_HOME="/opt/calibre/resources/recipes"
else
    CALIBRE_RECIPE_HOME="/Applications/calibre.app/Contents/Resources/resources/recipes"
fi

function send_to_my_kindle() {
  for each_recipe in "$@"; do
    echo "sending $each_recipe to my kindle..."
    ebook-convert $CALIBRE_RECIPE_HOME/$each_recipe.recipe /tmp/$each_recipe.mobi || exit 1

    zip -9 /tmp/$each_recipe.zip /tmp/$each_recipe.mobi || exit 1
    calibre-smtp -r smtp.gmail.com --username to.my.kindle@gmail.com --password sendtomykindle --port 587 -e TLS to.my.kindle@gmail.com pierodibello@free.kindle.com "here" -a /tmp/$each_recipe.zip

    rm -rf /tmp/$each_recipe.*
  done
}

if [ $# -lt 1 ]; then
  echo "Usage: $0 <recipe list>"
  echo "e.g. $0 la_republica corriere_della_sera_it"
  exit 1
fi

send_to_my_kindle $@
