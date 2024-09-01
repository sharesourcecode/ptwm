#!/system/bin/awk -f

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

BEGIN {
 # Diretórios a serem testados
 dir1 = "/storage/emulated/0"
 dir2 = ENVIRON["HOME"]

 # Verifica permissão de escrita para o primeiro diretório
 cmd = "test -w " dir1
 if (system(cmd) == 0) {
  print "O diretório " dir1 " tem permissão de escrita."
  working_dir = dir1
 } else {
  # Verifica permissão de escrita para o segundo diretório
  cmd = "test -w " dir2
  if (system(cmd) == 0) {
print "O diretório " dir2 " tem permissão de escrita."
working_dir = dir2
  } else {
print "Nenhum dos diretórios tem permissão de escrita."
exit 1
  }
 }

 # Define o diretório de trabalho
 print "Definindo o diretório de trabalho para: " working_dir
 # Note que o comando cd não mudará o diretório do shell chamador
}
