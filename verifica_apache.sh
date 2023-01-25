#! /bin/bash
#verifica_apache.sh

ip=$(hostname -I)
codigo_http=$(curl -s -o /dev/null -I -w "%{http_code}" $ip)

if [ $codigo_http -ne 200 ]; then

    echo "$(date +%F\ %T) Apache está OFFLINE! Código $codigo_http " >> /mnt/efs/lucasalves/servidor_off

    systemctl restart httpd

else

    echo "$(date +%F\ %T) Apache está ONLINE" >> /mnt/efs/lucasalves/servidor_on

fi

