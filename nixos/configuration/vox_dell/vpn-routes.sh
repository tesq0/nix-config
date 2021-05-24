#!/bin/sh

dns='10.118.80.90' # 10.8.12.90
ips=''
domains='gitlab.voxteam.pl vox.pl customer.vox.pl bw.vox.pl serwis.vox.pl'

route add $dns dev ppp0

let resolved
for domain in $domains; do
    resolved=$(dig +short $domain $dnsip | tail -n1)
    ips="$ips $resolved"
done

for ip in $ips; do
    route add $ip dev ppp0
done
