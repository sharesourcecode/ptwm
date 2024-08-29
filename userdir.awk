#!/system/bin/awk -f

BEGIN {
 while (1) {
  # Solicita ao usuário que digite um nome
  printf "Digite um nome para o diretório (apenas letras e espaços, sem múltiplos espaços): "
  getline nome < "-"

  # Verifica se o nome contém apenas letras e espaços
  if (nome !~ /^[a-zA-Z]+( [a-zA-Z]+)*$/) {
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
