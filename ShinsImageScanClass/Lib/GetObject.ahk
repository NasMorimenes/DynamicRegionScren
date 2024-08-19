GetBitmapWH(hBM, &w, &h) {

    size := ( A_PtrSize = 8 ? 32 : 24 )
    bm := Buffer( size, 0 )

    r := 
    DllCall(
        "GetObject",
        "Ptr",hBM,
        "int", size,
        "Ptr", bm,
        "Int"
    )

    w := NumGet( bm, 4, "int" )
    h := NumGet( bm, 8, "int" )
    h := Abs( h )

    return r
}

/*

A função GetObject (GetObject) recupera informações para o objeto gráfico especificado.

Sintaxe
```cpp
int GetObject(
  [in]  HANDLE h,
  [in]  int    c,
  [out] LPVOID pv
);
```

Parâmetros
- `h`: Um identificador para o objeto gráfico de interesse. Isso pode ser um identificador para um dos seguintes: um bitmap lógico, um pincel, uma fonte, uma paleta, uma caneta ou um bitmap independente de dispositivo criado chamando a função CreateDIBSection.
- `c`: O número de bytes de informações a serem escritos no buffer.
- `pv`: Um ponteiro para um buffer que recebe as informações sobre o objeto gráfico especificado.

Valor de retorno
- Se a função for bem-sucedida e `pv` for um ponteiro válido, o valor de retorno será o número de bytes armazenados no buffer.
- Se a função for bem-sucedida e `pv` for NULL, o valor de retorno será o número de bytes necessários para armazenar as informações que a função armazenaria no buffer.
- Se a função falhar, o valor de retorno será zero.

Observações
O buffer apontado pelo parâmetro `pv` deve ser suficientemente grande para receber as informações sobre o objeto gráfico. Dependendo do objeto gráfico, a função utiliza uma estrutura BITMAP, DIBSECTION, EXTLOGPEN, LOGBRUSH, LOGFONT ou LOGPEN, ou uma contagem de entradas de tabela (para uma paleta lógica).

Se `hgdiobj` for um identificador para um bitmap criado chamando a função CreateDIBSection e o buffer especificado for grande o suficiente, a função GetObject retorna uma estrutura DIBSECTION. Além disso, o membro bmBits da estrutura BITMAP contida dentro da DIBSECTION conterá um ponteiro para os valores de bits do bitmap.

Se `hgdiobj` for um identificador para um bitmap criado por qualquer outro meio, GetObject retorna apenas as informações de largura, altura e formato de cor do bitmap. Você pode obter os valores de bits do bitmap chamando a função GetDIBits ou GetBitmapBits.

Se `hgdiobj` for um identificador para uma paleta lógica, GetObject recupera um inteiro de 2 bytes que especifica o número de entradas na paleta. A função não recupera a estrutura LOGPALETTE que define a paleta. Para recuperar informações sobre entradas de paleta, um aplicativo pode chamar a função GetPaletteEntries.

Se `hgdiobj` for um identificador para uma fonte, o LOGFONT retornado é o LOGFONT usado para criar a fonte. Se o Windows precisou fazer alguma interpolação da fonte porque o LOGFONT preciso não pôde ser representado, a interpolação não será refletida no LOGFONT. Por exemplo, se você pedir uma versão vertical de uma fonte que não suporta pintura vertical, o LOGFONT indicará que a fonte é vertical, mas o Windows a pintará horizontalmente.