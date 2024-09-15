#!/usr/bin/awk -f

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

BEGIN {
    # Variáveis gerais
    CriptChars = "200,201,202,203,204,205,206,207,210,211,212,213,214,215,216,217,220,221,222,223,224,225,226,227,230,231,232,233,234,235,236,237,240,241,242,243,244,245,246,247,250,251,252,253,254,255,256,257,260,261,262,263,264,265,266,267,270,271,272,273,274,275,276,277,300,301,302,303,304,305,306,307,310,311,312,313,314,315,316,317,320,321,322,323,324,325,326,327,330,331,332,333,334,335,336,337,340,341,342,343,344,345,346,347,350,351,352,353,354,355,356,357,360,361,362,363,364,365,366,367,370,371,372,373,374,375,376,377"
    DecriptChars = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9,А,Б,В,Г,Д,Е,Ё,Ж,З,И,Й,К,Л,М,Н,О,П,Р,С,Т,У,Ф,Х,Ц,Ч,Ш,Щ,Ъ,Ы,Ь,Э,Ю,Я,а,б,в,г,д,е,ё,ж,з,и,й,к,л,м,н,о,п,р,с,т,у,ф,х,ц,ч,ш,щ,ъ,ы,ь,э,ю,я"

    split(CriptChars, CriptArray, ",")
    split(DecriptChars, DecriptArray, ",")

    AllCript = length(CriptArray)
    AllDecript = length(DecriptArray)

    # Verifica se a operação é de descriptografar
    if (ARG1 == "-d") {
        getline ReceiverPipe < "cript_file"
        print ReceiverPipe
        RandomChars = ""
        # Lê e decodifica a linha
        getline RandomChars < "cript_file"
        RandomChars = gensub(/.*:/, "", "g", RandomChars)
        RandomChars = system("echo " RandomChars " | base64 -d")
    } else {
        while ((getline ReceiverData < "-") > 0) {
            ReceiverPipe = gensub(/(.)(?=.)/, "&,", "g", ReceiverData)
            print ReceiverPipe | "base64"
        }
    }

    # Gera a ordem de posições
    ElementsPosition()

    if (ARG1 != "-d") {
        print "Gerando chave de criptografia aleatória..."
        RandomChars = ""

        for (i = 1; i <= AllDecript; i++) {
            OriginalPosition = SelectedPositions[i]
            RandomChars = (RandomChars ? RandomChars "," : "") CriptArray[OriginalPosition]
        }
    }

    # Cria arquivo temporário
    dir_ram = (system("test -d /dev/shm") == 0) ? "/dev/shm/" : "/tmp/"
    cmd = "mktemp " dir_ram "data.XXXXXX"
    cmd | getline cript_file
    close(cmd)

    print ReceiverPipe > cript_file

    # Criptografia ou descriptografia
    for (i = 1; i <= AllDecript; i++) {
        OpenChars = DecriptArray[i]
        ClosedChars = RandomChars[i]

        if (ARG1 == "-d") {
            system("sed -i 's/" ClosedChars "/" OpenChars "/g' " cript_file)
        } else {
            system("sed -i 's/" OpenChars "/" ClosedChars "/g' " cript_file)
        }
    }

    if (ARG1 != "-d") {
        print RandomChars | "base64"
        print "🔐 Sua senha está salva com segurança."
    } else {
        print "Tentando usar uma chave recente para descriptografar."
    }

    # Limpeza
    system("rm -rf " cript_file)
}

function ElementsPosition() {
    print "Formulando fator aleatório..."
    PositionOrder = ""
    for (i = 1; i <= AllCript; i++) {
        PositionOrder = (PositionOrder ? PositionOrder "," : "") i
    }
    SelectedPositions = ""
    split(PositionOrder, PositionArray, ",")
    for (i = 1; i <= AllDecript; i++) {
        SelectedPositions = (SelectedPositions ? SelectedPositions "," : "") PositionArray[int(rand() * AllCript) + 1]
    }
    print "Fator aleatório formulado ✓"
}
