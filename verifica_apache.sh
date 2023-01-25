#! /bin/bash
#verifica_apache.sh

ip=$(hostname -I)
codigo_http=$(curl -s -o /dev/null -I -w "%{http_code}" $ip)

if [ $codigo_http -ne 200 ]; then

    echo "Houve um problema, o servidor está OFFLINE! Código $codigo_http  $(date +%F\ %T)" >> /home/lucas/logs/servidor_off.log

    systemctl restart httpd

else

    echo "O servidor está ONLINE  $(date +%F\ %T)" >> /home/lucas/logs/servidor_on.log

fi

