#!/usr/bin/env sh
curl -L "https://adaway.org/hosts.txt" > bad-hosts
curl -L "https://pgl.yoyo.org/adservers/serverlist.php" -d hostformat=hosts -d showintro=0 -d mimetype=plaintext >> bad-hosts
curl -L "https://someonewhocares.org/hosts/zero/hosts" >> bad-hosts
sed -i -e '/\#<localhost>/,/\#<\/localhost>/d' \
		-e 's/\#.*//g' \
		-e '/localhost/d' \
		-e '/^\s*$/d' bad-hosts
