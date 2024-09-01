#!/usr/bin/awk -f

BEGIN {
 ARQUIVO_SENHA = "senha.txt"
 captura_senha()
}

function captura_senha() {
 printf "Digite a senha (apenas letras, números e caracteres russos): "
 getline senha < "/dev/tty"

 if (senha ~ /^[a-zA-Z0-9а-яА-ЯёЁ]+$/) {
  print senha > ARQUIVO_SENHA
  print "Senha salva com sucesso em " ARQUIVO_SENHA "."
 } else {
  print "Senha inválida. A senha deve conter apenas letras, números e caracteres russos."
  captura_senha()  # Chama a função novamente para nova tentativa
 }
}
