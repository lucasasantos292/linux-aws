#!/bin/bash
#verifica_apache.sh

ip_publico=$(curl ifconfig.me)
codigo_http=$(curl --write-out %{http_code} --silent --output /dev/null https://$ip_publico/)

if [ $codigo_http -ne 200 ]; then

    echo "Houve um problema, o servidor está OFFLINE! $codigo_http  $(date +%F\ %T)" >> /logs/servidor_of.log

    systemctl restart httpd

fi

if [ $codigo_http -e 200 ]; then

    echo "O servidor está ONLINE  $(date +%F\ %T)" >> /logs/servidor_on.log

fi

