#!/usr/bin/awk -f

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

BEGIN {
 # Definindo as variáveis de login
 LOGIN = "awk"
 PASSWORD = "0123456789"
 URL = "http://furiadetitas.net/?sign_in=1"
 COOKIE_FILE = "cookies.txt"
 CHECK_STRING = "user=0;level=0"

 # Passo 1: Gera os cookies (saída oculta)
 print "Gerando cookies..."
 command = "curl --max-time 10 --retry 1 -s -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3' " \
  "-d 'login=" LOGIN "&pass=" PASSWORD "' " \
  "-c " COOKIE_FILE " '" URL "' | grep -q '" CHECK_STRING "'"
 result = system(command)

 if (result != 0) {
  print "Erro ao gerar cookies. Verifique sua conexão com a internet."
  exit 1
 }

 # Passo 2: Faz login e verifica a resposta usando grep
 print "Fazendo login..."
 command = "curl --max-time 10 --retry 1 -s -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3' " \
  "-d 'login=" LOGIN "&pass=" PASSWORD "' " \
  "-b " COOKIE_FILE " '" URL "' | grep -q '" CHECK_STRING "'"
 result = system(command)

 if (result == 0) {
  print "Erro ao fazer login. Verifique as credenciais ou sua conexão com a internet."
  exit 1
 } else {
  print "Login realizado com sucesso!"
 }
}
