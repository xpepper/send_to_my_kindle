#!/bin/bash

ebook-convert /opt/calibre/resources/recipes/la_republica.recipe /tmp/la_repubblica.mobi

zip -9 /tmp/la_repubblica.zip /tmp/la_repubblica.mobi
calibre-smtp -r smtp.gmail.com --username to.my.kindle@gmail.com --password sendtomykindle --port 587 -e TLS -vv to.my.kindle@gmail.com pierodibello@free.kindle.com "here it is" -a /tmp/la_repubblica.zip

