#Include StructCpp.ahk
CreateDIBSection( MDC, captureWidth, captureHeight, &ppvBits := 0 ) {
	MsgBox( MDC )
	BI := Buffer(40, 0)
     NumPut("UInt", 40, BI, 0)
     NumPut("Int", captureWidth, BI, 4)
     NumPut("Int", -captureHeight, BI, 8)
     NumPut("Short", 1, BI, 12)
     NumPut("Short", 32, BI, 14)

     MsgBox( "BI" BI.size ) 
	hBM := 
	DllCall(
		"CreateDIBSection",
		"Ptr", MDC,
		"Ptr", BI,
		"Int", 0,
		"Ptr*", &ppvBits,
		"Ptr", 0,
		"Int", 0,
		"Ptr"
	)
     BINFO := ""
	
	return hBM
}

/*

A função CreateDIBSection (wingdi.h) cria um DIB (Device-Independent Bitmap) que as aplicações podem escrever diretamente. A função fornece um ponteiro para a localização dos valores dos bits do bitmap. Você pode fornecer um identificador para um objeto de mapeamento de arquivo que a função usará para criar o bitmap, ou pode deixar o sistema alocar a memória para o bitmap.

Sintaxe
C++

```cpp
HBITMAP CreateDIBSection(
  [in]  HDC              hdc,
  [in]  const BITMAPINFO *pbmi,
  [in]  UINT             usage,
  [out] VOID             **ppvBits,
  [in]  HANDLE           hSection,
  [in]  DWORD            offset
);
```

Parâmetros
[in] hdc

Um identificador para um contexto de dispositivo. Se o valor de iUsage for DIB_PAL_COLORS, a função usa a paleta lógica desse contexto de dispositivo para inicializar as cores do DIB.

[in] pbmi

Um ponteiro para uma estrutura BITMAPINFO que especifica vários atributos do DIB, incluindo as dimensões do bitmap e cores.

[in] usage

O tipo de dados contidos no membro bmiColors da estrutura BITMAPINFO apontada por pbmi (índices de paleta lógica ou valores RGB literais). Os seguintes valores são definidos.

Value	Meaning
DIB_PAL_COLORS
O membro bmiColors é uma matriz de índices de 16 bits na paleta lógica do contexto de dispositivo especificado por hdc.
DIB_RGB_COLORS
A estrutura BITMAPINFO contém uma matriz de valores RGB literais.
[out] ppvBits

Um ponteiro para uma variável que recebe um ponteiro para a localização dos valores dos bits do DIB.

[in] hSection

Um identificador para um objeto de mapeamento de arquivo que a função usará para criar o DIB. Este parâmetro pode ser NULL.

Se hSection não for NULL, ele deve ser um identificador para um objeto de mapeamento de arquivo criado chamando a função CreateFileMapping com a flag PAGE_READWRITE ou PAGE_WRITECOPY. Seções de DIB somente leitura não são suportadas. Identificadores criados de outras maneiras farão com que CreateDIBSection falhe.

Se hSection não for NULL, a função CreateDIBSection localiza os valores dos bits do bitmap no deslocamento dwOffset no objeto de mapeamento de arquivo referenciado por hSection. Uma aplicação pode posteriormente recuperar o identificador hSection chamando a função GetObject com o HBITMAP retornado por CreateDIBSection.

Se hSection for NULL, o sistema aloca memória para o DIB. Nesse caso, a função CreateDIBSection ignora o parâmetro dwOffset. Uma aplicação não pode posteriormente obter um identificador para esta memória. O membro dshSection da estrutura DIBSECTION preenchida chamando a função GetObject será NULL.

[in] offset

O deslocamento a partir do início do objeto de mapeamento de arquivo referenciado por hSection onde o armazenamento para os valores dos bits do bitmap deve começar. Este valor é ignorado se hSection for NULL. Os valores dos bits do bitmap são alinhados em limites de palavras duplas, portanto, dwOffset deve ser um múltiplo do tamanho de um DWORD.

Valor de retorno
Se a função for bem-sucedida, o valor de retorno será um identificador para o DIB recém-criado, e *ppvBits apontará para os valores dos bits do bitmap.

Se a função falhar, o valor de retorno será NULL, e *ppvBits será NULL. Para obter informações de erro estendidas, chame GetLastError.

GetLastError pode retornar o seguinte valor:

Error code	Description
ERROR_INVALID_PARAMETER
Um ou mais dos parâmetros de entrada são inválidos.

Observações
Conforme observado acima, se hSection for NULL, o sistema aloca memória para o DIB. O sistema fecha o identificador para essa memória quando você exclui posteriormente o DIB chamando a função DeleteObject. Se hSection não for NULL, você mesmo deverá fechar o identificador de memória hSection depois de chamar DeleteObject para excluir o bitmap.

Você não pode colar uma seção de DIB de uma aplicação em outra aplicação.

CreateDIBSection não usa os parâmetros biXPelsPerMeter ou biYPelsPerMeter do BITMAPINFOHEADER e não fornecerá informações de resolução na estrutura BITMAPINFO.

Você precisa garantir que o subsistema GDI tenha concluído qualquer desenho em um bitmap criado por CreateDIBSection antes de desenhar no bitmap você mesmo. O acesso ao bitmap deve ser sincronizado. Faça isso chamando a função GdiFlush. Isso se aplica a qualquer uso do ponteiro para os valores dos bits do bitmap, incluindo passar o ponteiro em chamadas de funções como SetDIBits.

ICM: Nenhuma gerenciamento de cores é feito.