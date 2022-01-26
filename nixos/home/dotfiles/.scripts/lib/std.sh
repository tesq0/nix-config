#!/bin/sh

escape_dot() {
    sed 's/\./\\\./'
}

trim() {
    sed -e 's/^[[:space:]]*//'
}

set_xresources_var() {
    var_name=$1
    var_value=$2
    if [ -z "$(grep ^$var_name ~/.Xresources )" ] ; then
	printf "\n%s: %s" "$var_name" "$var_value" >> ~/.Xresources 
    else
	cmd='{ m = "%s"; print gensub(/(%s: ).*/, "\\\\1"m, "g", $0) }'
	cmd=$(printf "$cmd" $var_value $var_name)
	out=$(cat ~/.Xresources | awk "$cmd")
	if [ -z "$out" ] ; then
	    echo "AWK ERROR: empty out" && exit 1
	fi
	echo "$out" > ~/.Xresources 
    fi
}

