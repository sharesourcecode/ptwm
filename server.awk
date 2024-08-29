#!/system/bin/awk -f
BEGIN {
 while (1) {
  print ""
  print "Digite o número do servidor"
  print "e confirme:"
  print " 1. tiwar.net"
  print " 2. tiwar.ru"
  print " 3. tiwar.pl"
  print " 4. titanen.mobi"
  print " 5. guerradetitanes.net"
  print " 6. furiadetitas.net"
  print " 7. guerradititani.net"
  print " 8. tiwar.fr"
  print " 9. tiwar.ro"
  print "10. cn.tiwar.net"
  print "11. tiwar-id.net"
  print ""
  getline opt < "-"
  # Verifica a opção escolhida
  if (opt == 1) {
   print " 1. tiwar.net"
   break
  } else if (opt == 2) {
   print " 2. tiwar.ru"
   break
  } else if (opt == 3) {
   print " 3. tiwar.pl"
   break
  } else if (opt == 4) {
   print " 4. titanen.mobi"
   break
  } else if (opt == 5) {
   print " 5. guerradetitanes.net"
   break
  } else if (opt == 6) {
   print " 6. furiadetitas.net"
   break
  } else if (opt == 7) {
   print " 7. guerradititani.net"
   break
  } else if (opt == 8) {
   print " 8. tiwar.fr"
   break
  } else if (opt == 9) {
   print " 9. tiwar.ro"
   break
  } else if (opt == 10) {
   print "10. cn.tiwar.net"
   break
  } else if (opt == 11) {
   print "11. tiwar-id.net"
   break
  } else {
   print "Opção inválida. Tente novamente."
  }
 }
 # Salva a opção escolhida em uma variável
 selected = opt

 # Salva a opção escolhida em um arquivo
 print selected > "server.txt"
 print "Salvo em 'server.txt'."
}
