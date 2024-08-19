
CreateCompatibleDC( hScreen ) {
    hDC :=
    DllCall(
        "CreateCompatibleDC",
        "Ptr", hScreen
    )
    return hDC
}
/*
A função CreateCompatibleDC cria um contexto de dispositivo de memória (DC) compatível com o dispositivo especificado.

Sintaxe
C++

```
Copy
HDC CreateCompatibleDC(
  [in] HDC hdc
);
```

Parâmetros
[in] hdc

Um identificador para um DC existente. Se este identificador for NULL, a função cria um DC de memória compatível com a tela atual da aplicação.

Valor de retorno
Se a função for bem-sucedida, o valor de retorno será o identificador para um DC de memória.

Se a função falhar, o valor de retorno será NULL.

Observações
Um DC de memória existe apenas na memória. Quando o DC de memória é criado, sua superfície de exibição é exatamente um pixel monocromático de largura e um pixel monocromático de altura. Antes que uma aplicação possa usar um DC de memória para operações de desenho, ela deve selecionar um bitmap com a largura e altura corretas no DC. Para selecionar um bitmap em um DC, use a função CreateCompatibleBitmap, especificando a altura, largura e organização de cores necessárias.

Quando um DC de memória é criado, todos os atributos são definidos para os valores padrão normais. O DC de memória pode ser usado como um DC normal. Você pode definir os atributos; obter as configurações atuais de seus atributos; e selecionar canetas, pincéis e regiões.

A função CreateCompatibleDC só pode ser usada com dispositivos que suportam operações de rasterização. Uma aplicação pode determinar se um dispositivo suporta essas operações chamando a função GetDeviceCaps.

Quando você não precisar mais do DC de memória, chame a função DeleteDC. Recomendamos que você chame DeleteDC para excluir o DC. No entanto, você também pode chamar DeleteObject com o HDC para excluir o DC.

Se hdc for NULL, a thread que chama CreateCompatibleDC possui o HDC que é criado. Quando esta thread for destruída, o HDC não será mais válido. Assim, se você criar o HDC e passá-lo para outra thread e, em seguida, sair da primeira thread, a segunda thread não poderá usar o HDC.

ICM: Se o DC passado para esta função estiver habilitado para Gerenciamento de Cores de Imagem (ICM), o DC criado pela função será habilitado para ICM. Os espaços de cores de origem e destino são especificados no DC.