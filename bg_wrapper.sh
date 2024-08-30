#!/bin/sh

# Verifica se o arquivo de entrada foi fornecido
if [ -z "$1" ]; then
 echo "Uso: $0 arquivo"
 exit 1
fi

# Executa o comando awk em segundo plano
awk '{ print $1 }' "$1" &

# Captura o PID do processo em segundo plano
PID=$!

echo "O comando awk está rodando em segundo plano com PID: $PID"
