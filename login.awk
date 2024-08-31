#!/usr/bin/awk -f

BEGIN {
 # Definindo as variáveis de login
 LOGIN = "awk"
 PASSWORD = "1234567890"
 URL = "http://furiadetitas.net/?sign_in=1"
 COOKIE_FILE = "cookies.txt"

 # Passo 1: Gera os cookies
 print "Gerando cookies..."
 command = "curl -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3' " \
  "-d 'login=" LOGIN "&pass=" PASSWORD "' " \
  "-c " COOKIE_FILE " '" URL "'"
 result = system(command)

 if (result != 0) {
  print "Erro ao gerar cookies."
  exit 1
 }

 # Passo 2: Faz login
 print "Fazendo login..."
 command = "curl -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3' " \
  "-d 'login=" LOGIN "&pass=" PASSWORD "' " \
  "-b " COOKIE_FILE " '" URL "'"
 result = system(command)

 if (result != 0) {
  print "Erro ao fazer login."
  exit 1
 }

 print "Login realizado com sucesso!"
}
