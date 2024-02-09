#!/bin/bash
# Este script verifica o status do serviço apache2  e salva o resultado no diretório /mnt/nfs/isaque

DATA=$(date +%d/%m/%Y)
HORA=$(date +%H:%M:%S)
SERVICO="httpd"
STATUS=$(systemctl is-active $SERVICO)

if [ $STATUS == "active" ]; then
    MENSAGEM="O $SERVICO está ONLINE"
    echo "$DATA $HORA - $SERVICO - active - $MENSAGEM" >> /mnt/nfs/isaque/online.txt
else
    MENSAGEM="O $SERVICO está offline"
    echo "$DATA $HORA - $SERVICO - inactive - $MENSAGEM" >> /mnt/nfs/isaque/offline.txt
fi
