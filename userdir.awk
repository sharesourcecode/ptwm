#!/system/bin/awk -f

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

BEGIN {
  while (1) {
 # Solicita ao usuário que digite um nome
 printf "Digite um nome para o diretório (apenas letras, espaços e caracteres especiais permitidos): "
 getline nome < "-"

 # Verifica se o nome contém apenas letras (incluindo russo) e espaços
 if (nome !~ /^[a-zA-Zа-яА-ЯёЁ]+( [a-zA-Zа-яА-ЯёЁ]+)*$/) {
print "O nome deve conter apenas letras e espaços."
continue
 }

 # Verifica se há múltiplos espaços
 if (nome ~ /  +/) {
print "Por favor, não use múltiplos espaços. Tente novamente."
continue
 }

 # Substitui espaços por underscores
 gsub(/ /, "_", nome)

 # Cria o diretório
 cmd = "mkdir -p \"" nome "\""
 if (system(cmd) == 0) {
print "Diretório \"" nome "\" criado com sucesso."
break
 } else {
print "Erro ao criar o diretório \"" nome "\"."
 }
  }
}
