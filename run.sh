#!/bin/bash

[[ ! -d logs ]] && mkdir logs
[[ ! -d media ]] && mkdir media

docker run -d -v `pwd`/logs:/logs -v `pwd`/media:/media -p 32400:32400 plexmediaserver

# open http://192.168.99.100:32400/web/index.html
