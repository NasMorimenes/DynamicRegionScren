SelectObject( HDC, HGDIOBJ ) {
    sHGDIOBJ :=
    DllCall(
        "SelectObject",
        "Ptr", hDC,
        "Ptr", HGDIOBJ
    )
    return sHGDIOBJ
}


/*
A função SelectObject seleciona um objeto no contexto de dispositivo (DC) especificado. O novo objeto substitui o objeto anterior do mesmo tipo.

Sintaxe

```cpp
HGDIOBJ SelectObject(
  [in] HDC     hdc,
  [in] HGDIOBJ h
);
```

Parâmetros

[in] hdc

Um identificador para o DC.

[in] h

Um identificador para o objeto a ser selecionado. O objeto especificado deve ter sido criado usando uma das seguintes funções.

Objeto	Funções
Bitmap	CreateBitmap, CreateBitmapIndirect, CreateCompatibleBitmap, CreateDIBitmap, CreateDIBSection

Bitmaps só podem ser selecionados em DCs de memória. Um único bitmap não pode ser selecionado em mais de um DC ao mesmo tempo.

Brush	CreateBrushIndirect, CreateDIBPatternBrush, CreateDIBPatternBrushPt, CreateHatchBrush, CreatePatternBrush, CreateSolidBrush

Font	CreateFont, CreateFontIndirect

Pen	CreatePen, CreatePenIndirect

Region	CombineRgn, CreateEllipticRgn, CreateEllipticRgnIndirect, CreatePolygonRgn, CreateRectRgn, CreateRectRgnIndirect

Valor de retorno

Se o objeto selecionado não for uma região e a função for bem-sucedida, o valor de retorno será um identificador para o objeto que está sendo substituído. Se o objeto selecionado for uma região e a função for bem-sucedida, o valor de retorno será um dos seguintes valores.

Valor	Significado
SIMPLEREGION	Região consiste em um único retângulo.
COMPLEXREGION	Região consiste em mais de um retângulo.
NULLREGION	Região está vazia.

Se ocorrer um erro e o objeto selecionado não for uma região, o valor de retorno será NULL. Caso contrário, será HGDI_ERROR.

Observações

Esta função retorna o objeto previamente selecionado do tipo especificado. Uma aplicação deve sempre substituir um novo objeto pelo objeto original, padrão, após ter terminado de desenhar com o novo objeto.

Uma aplicação não pode selecionar um único bitmap em mais de um DC ao mesmo tempo.

ICM: Se o objeto sendo selecionado for um pincel ou uma caneta, o gerenciamento de cores é realizado.