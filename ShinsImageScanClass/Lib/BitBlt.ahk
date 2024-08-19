BitBlt( hDC, dW, dH, hdcSrc, dX := 0, dY := 0, sX := 0, sY := 0 ) {
	Bool := 
    DllCall(
		"BitBlt",
		"Ptr"	, hDC,
		"Int"	, dX,
		"Int"	, dY,
		"Int"	, dW,
		"Int"	, dH,
		"Ptr"	, hdcSrc,
		"Int"	, sX,
		"Int"	, sY,
		"UInt" , 0xCC0020,
    "Int"
	)
    return Bool
}

/*
A função BitBlt realiza uma transferência de bloco de bits dos dados de cor correspondentes a um retângulo de pixels do contexto de dispositivo (DC) de origem especificado para um contexto de dispositivo de destino.

Sintaxe

```cpp
BOOL BitBlt(
  [in] HDC   hdc,
  [in] int   x,
  [in] int   y,
  [in] int   cx,
  [in] int   cy,
  [in] HDC   hdcSrc,
  [in] int   x1,
  [in] int   y1,
  [in] DWORD rop
);
```

Parâmetros

[in] hdc

Um identificador para o contexto de dispositivo de destino.

[in] x

A coordenada x, em unidades lógicas, do canto superior esquerdo do retângulo de destino.

[in] y

A coordenada y, em unidades lógicas, do canto superior esquerdo do retângulo de destino.

[in] cx

A largura, em unidades lógicas, dos retângulos de origem e de destino.

[in] cy

A altura, em unidades lógicas, dos retângulos de origem e de destino.

[in] hdcSrc

Um identificador para o contexto de dispositivo de origem.

[in] x1

A coordenada x, em unidades lógicas, do canto superior esquerdo do retângulo de origem.

[in] y1

A coordenada y, em unidades lógicas, do canto superior esquerdo do retângulo de origem.

[in] rop

Um código de operação de rasterização. Esses códigos definem como os dados de cor do retângulo de origem devem ser combinados com os dados de cor do retângulo de destino para obter a cor final.

O seguinte lista alguns códigos de operação de rasterização comuns.

Valor	Significado
BLACKNESS	Preenche o retângulo de destino usando a cor associada ao índice 0 na paleta física. (Essa cor é preta para a paleta física padrão.)
CAPTUREBLT	Inclui quaisquer janelas que estão sobreposta à sua janela na imagem resultante. Por padrão, a imagem contém apenas sua janela. Note que isso geralmente não pode ser usado para contextos de dispositivos de impressão.
DSTINVERT	Inverte o retângulo de destino.
MERGECOPY	Mescla as cores do retângulo de origem com o pincel atualmente selecionado em hdcDest, usando o operador AND booleano.
MERGEPAINT	Mescla as cores do retângulo de origem invertido com as cores do retângulo de destino usando o operador OR booleano.
NOMIRRORBITMAP	Previne que o bitmap seja espelhado.
NOTSRCCOPY	Copia o retângulo de origem invertido para o destino.
NOTSRCERASE	Combina as cores dos retângulos de origem e de destino usando o operador OR booleano e depois inverte a cor resultante.
PATCOPY	Copia o pincel atualmente selecionado em hdcDest para o bitmap de destino.
PATINVERT	Combina as cores do pincel atualmente selecionado em hdcDest com as cores do retângulo de destino usando o operador XOR booleano.
PATPAINT	Combina as cores do pincel atualmente selecionado em hdcDest com as cores do retângulo de origem invertido usando o operador OR booleano. O resultado desta operação é combinado com as cores do retângulo de destino usando o operador OR booleano.
SRCAND	Combina as cores dos retângulos de origem e de destino usando o operador AND booleano.
SRCCOPY	Copia diretamente o retângulo de origem para o retângulo de destino.
SRCERASE	Combina as cores invertidas do retângulo de destino com as cores do retângulo de origem usando o operador AND booleano.
SRCINVERT	Combina as cores dos retângulos de origem e de destino usando o operador XOR booleano.
SRCPAINT	Combina as cores dos retângulos de origem e de destino usando o operador OR booleano.
WHITENESS	Preenche o retângulo de destino usando a cor associada ao índice 1 na paleta física. (Essa cor é branca para a paleta física padrão.)
Valor de retorno

Se a função for bem-sucedida, o valor de retorno será diferente de zero.

Se a função falhar, o valor de retorno será zero. Para obter informações de erro estendidas, chame GetLastError.

Observações

BitBlt só faz recorte no DC de destino.

Se uma transformação de rotação ou inclinação estiver em vigor no contexto de dispositivo de origem, BitBlt retorna um erro. Se outras transformações existirem no contexto de dispositivo de origem (e uma transformação correspondente não estiver em vigor no contexto de dispositivo de destino), o retângulo no contexto de dispositivo de destino será esticado, comprimido ou rotacionado, conforme necessário.

Se os formatos de cor dos contextos de dispositivo de origem e de destino não coincidirem, a função BitBlt converterá o formato de cor de origem para coincidir com o formato de destino.

Quando um metafile aprimorado está sendo gravado, ocorre um erro se o contexto de dispositivo de origem identificar um contexto de dispositivo de metafile aprimorado.

Nem todos os dispositivos suportam a função BitBlt. Para mais informações, consulte a entrada de capacidade de rasterização RC_BITBLT na função GetDeviceCaps, bem como as seguintes funções: MaskBlt, PlgBlt e StretchBlt.

BitBlt retorna um erro se os contextos de dispositivo de origem e de destino representarem dispositivos diferentes. Para transferir dados entre DCs para dispositivos diferentes, converta o bitmap de memória em um DIB chamando GetDIBits. Para exibir o DIB no segundo dispositivo, chame SetDIBits ou StretchDIBits.

ICM: Nenhum gerenciamento de cores é realizado quando as transferências de blocos de bits ocorrem.