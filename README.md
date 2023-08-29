# twm(Titans War Macro)
Script macros para Titans war mobile game em todos servidores.

**Necessário level 16+ e +50 pontos de treinamento para entrar no coliseu e outras batalhas**

***Android 6 ou superior***

>1 - Abra o app Termux(https://f-droid.org/repo/com.termux_117.apk) no Android e digite ou cole:
```bash
apt install curl -y
```
>2 - Copie e cole este comando para baixar o instalador do twm(O link faz parte do comando):
```bash
curl https://raw.githubusercontent.com/sharesourcecode/twm/master/easyinstall.sh -O -L
```
>3 - Copie e cole este comando para instalar o twm:
```bash
bash easyinstall.sh
```
>4 - Para executar o twm:
```bash
bash twm/play.sh
```
Executar em modo caverna:
```bash
bash twm/play.sh -cv
```
Modo de prioridade coliseu:
```bash
bash twm/play.sh -cl
```

* Para interroper `CTRL c` ou force a parada do app Termux

* Desinstalar scripts:

`rm -rf $HOME/twm`
* Remover atalho do Termux boot:

`rm -rf $HOME/.termux/boot/play.sh`

*Faço atualizações e correções periodicas, caso queira manter os scripts atualizados em seu dispositivo reexecute as instruções acima a partir da segunda etapa.

As atualizações são exibidas nesta página: https://github.com/sharesourcecode/twm/commits/master
Clique em uma delas para saber o que foi alterado.* 

***
***Android 4.4 ou superior***

>1 - Abra o app UserLAnd(https://f-droid.org/repo/tech.ula_2927098.apk) no Android, instale o Debian com SSH e entre com a senha que foi criada.
> Em sequida digite, ou copie e cole para atualizar as listas de pacotes:

```sudo apt update -y```

>2 - Digite ou copie e cole este comando para baixar os pacotes necessários:

```sudo apt install curl openssl openssl-tool w3m procps coreutils ncurses-term dnsutils-y```

>3 - Copie e cole este comando para baixar o instalador do twm(O link faz parte do comando):

```curl https://raw.githubusercontent.com/sharesourcecode/twm/master/easyinstall.sh```

>4 - Copie e cole este comando para instalar o twm:

```bash easyinstall.sh```

>5 - Para executar o twm:

```bash twm/play.sh```

Executar em modo caverna:

```bash twm/play.sh -cv```

Modo de prioridade coliseu:

```bash twm/play.sh -cl```

`Para interroper (CTRL c) ou force a parada do app UserLand`

***
***Windows com Cygwin***

>1 - Abra o progama Cygwin(https://www.cygwin.com/setup-x86_64.exe) ou (https://www.cygwin.com/setup-x86.exe) como adiministrador no Windows. Na instalação selecione qualquer link, a parti daí é só dá Next até concluir. Em sequida com adiministrador abra o Cygwin Terminal que foi instalado. Digite, ou copie e cole o comando abaixo para baixar o instalador do twm(O link faz parte do comando):

```curl https://raw.githubusercontent.com/sharesourcecode/twm/master/easyinstall.sh -O -L```

>2 - Copie e cole este comando para instalar o twm:

```bash $HOME/easyinstall.sh```

>3 - Para executar o twm:

```bash $HOME/twm/play.sh```

Executar em modo caverna:

```bash $HOME/twm/play.sh -cv```

Modo de prioridade coliseu:

```bash $HOME/twm/play.sh -cl```

`Para interroper (CTRL c) ou feche o programa Cygwin`

***
***Distribuição Alt Linux, ou base Debian e Ubuntu - Windows WSL***

>1 - No emulador de terminal digite, ou copie e cole para atualizar as listas de pacotes:

```sudo apt-get update -y```

>2 - Digite ou copie e cole este comando para baixar os pacotes necessários:

```sudo apt-get install curl openssl w3m procps -y```

Opcional: ```sudo apt-get install openssl-tool coreutils dnsutils-y```

>3 - Copie e cole este comando para baixar o instalador do twm(O link faz parte do comando):

```curl https://raw.githubusercontent.com/sharesourcecode/twm/master/easyinstall.sh -O -L```

>4 - Copie e cole este comando para instalar o twm:

```bash easyinstall.sh```

>5 - Comando para executar o twm:

```bash twm/play.sh```

Executar em modo caverna:

```bash twm/play.sh -cv```

Modo de prioridade coliseu:

```bash twm/play.sh -cl```

`Para interroper (CTRL c)`
