#Include MCode1.ahk


MsgBox( RandomColorBuff() )

Esc::ExitApp()


RandomColorBuff( ) { ;buff, sw, sh, Stride ) {

    Hex := "534883ec20e80000000089c3e800000000c1e3100fb7c009d84883c4205bc3"

    Code := MCode1( Hex )

    return Call( Code ) ;, buff, sw, sh, Stride )

    Call( Code ) { ;, buff, sw, sh, Stride ) {
        ;buff, sw, sh, Stride ) {
        result :=
        DllCall(
            Code,
            "UInt"
        )
        /*
            "UPtr", Buff.Ptr,
            "Int", sw,
            "Int", sh,
            "Int", Stride,
            "int"
        )
        */
        return result
    }

}

/*



#include<stdio.h>
#include<stdlib.h>
#include<time.h>

int RandomColor() {
    int ala;

    ala = rand();

    return ala;
}



// Função que gera uma cor aleatória no formato 0xAARRGGBB e preenche o buffer
int RandomColor() { 

    // unsigned int color;  // Declaração da variável color

    // Variáveis para iteração
    // int x, y, o = 0;
    int z;

    srand(time(NULL));
    
    // gerando valores aleatórios na faixa de 0 a 100
    //rand() % 255;    
    z = rand() % 256;

    return z;

}

    for (y = 0; y < sh; y++) {

        for (x = 0; x < sw; x++, o++) {
            
            // Gera um número aleatório de 32 bits no formato ARGB (0xAARRGGBB)
            if (rand_s(&rand_value) != 0) {
                return 1;
            }
            color = rand_value;
            buffer[o] = color;  // Preenche o buffer com a cor aleatória
        }

        o += (Stride / 4) - sw;  // Ajusta o offset para pular o padding no final de cada linha, se houver
    }

    return 0;
}