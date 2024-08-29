#!/usr/bin/awk -f

BEGIN {
 ARQUIVO_SENHA = "senha.txt"
 captura_senha()
}

function captura_senha() {
 printf "Digite a senha (apenas letras e números): "
 getline senha < "/dev/tty"

 if (senha ~ /^[a-zA-Z0-9]+$/) {
  print senha > ARQUIVO_SENHA
  print "Senha salva com sucesso em " ARQUIVO_SENHA "."
 } else {
  print "Senha inválida. A senha deve conter apenas letras e números."
  captura_senha()  # Chama a função novamente para nova tentativa
 }
}
