CreateCompatibleBitmap( hdc, width, height ) {
    ; Chamando a função DllCall para criar um bitmap compatível
    hBitmap :=
    DllCall(
        "CreateCompatibleBitmap",
        "Ptr", hdc,
        "Int", width,
        "Int", height
    )
    ; Retornando o identificador do bitmap criado
    return hBitmap
}

/*
A função CreateCompatibleBitmap cria um bitmap compatível com o dispositivo associado ao contexto de dispositivo especificado.

Sintaxe
C++

```
Copy
HBITMAP CreateCompatibleBitmap(
  [in] HDC hdc,
  [in] int cx,
  [in] int cy
);
```

Parâmetros
    [in] hdc - Um identificador para um contexto de dispositivo.
    [in] cx - A largura do bitmap, em pixels.
    [in] cy - A altura do bitmap, em pixels.

Valor de retorno
Se a função for bem-sucedida, o valor de retorno será um identificador para o bitmap compatível (DDB).

Se a função falhar, o valor de retorno será NULL.

Observações
O formato de cor do bitmap criado pela função CreateCompatibleBitmap corresponde ao formato de cor do dispositivo identificado pelo parâmetro hdc. Este bitmap pode ser selecionado em qualquer contexto de dispositivo de memória que seja compatível com o dispositivo original.

Como os contextos de dispositivo de memória permitem bitmaps tanto coloridos quanto monocromáticos, o formato do bitmap retornado pela função CreateCompatibleBitmap difere quando o contexto de dispositivo especificado é um contexto de dispositivo de memória. No entanto, um bitmap compatível que foi criado para um contexto de dispositivo não de memória sempre possui o mesmo formato de cor e utiliza a mesma paleta de cores que o contexto de dispositivo especificado.

Observação: Quando um contexto de dispositivo de memória é criado, ele inicialmente tem um bitmap monocromático de 1 por 1 pixel selecionado nele. Se este contexto de dispositivo de memória for usado em CreateCompatibleBitmap, o bitmap criado será um bitmap monocromático. Para criar um bitmap colorido, use o HDC que foi usado para criar o contexto de dispositivo de memória, como mostrado no código a seguir:

C++

```
Copy
HDC memDC = CreateCompatibleDC ( hDC );
HBITMAP memBM = CreateCompatibleBitmap ( hDC, nWidth, nHeight );
SelectObject ( memDC, memBM );
```

Se uma aplicação definir os parâmetros nWidth ou nHeight como zero, CreateCompatibleBitmap retornará o identificador para um bitmap monocromático de 1 por 1 pixel.

Se uma seção DIB, que é um bitmap criado pela função CreateDIBSection, for selecionada no contexto de dispositivo identificado pelo parâmetro hdc, CreateCompatibleBitmap cria uma seção DIB.

Quando você não precisar mais do bitmap, chame a função DeleteObject para excluí-lo.
