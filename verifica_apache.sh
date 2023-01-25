#! /bin/bash
#verifica_apache.sh

ip=$(hostname -I)
codigo_http=$(curl -s -o /dev/null -I -w "%{http_code}" $ip)

if [ $codigo_http -ne 200 ]; then

    echo "$(date +%F\ %T) Apache está OFFLINE! Código $codigo_http " >> /home/lucas/logs/servidor_off.log

    systemctl restart httpd

else

    echo "$(date +%F\ %T) Apache está ONLINE" >> /home/lucas/logs/servidor_on.log

fi

