/**
 * Recorta uma imagem bitmap para as coordenadas e dimensões especificadas.
 *
 * 
 * @param {ptr} pBitmap - Um ponteiro para o bitmap a ser recortado.
 * @param {int} x - A coordenada x do canto superior esquerdo da área de recorte.
 * @param {int} y - A coordenada y do canto superior esquerdo da área de recorte.
 * @param {int} w - A largura da área de recorte.
 * @param {int} h - A altura da área de recorte.
 * @returns {ptr} - Um ponteiro para o bitmap recortado.
 * @description - Esta função BitmapCrop recorta uma imagem bitmap para as coordenadas
 * 				  e dimensões especificadas, validando os valores de entrada e ajustando-os
 * 				  conforme necessário. Ela usa chamadas de funções GDI+ para obter as
 * 				  propriedades da imagem e realizar a operação de recorte.
 *
 * @throws Gera um erro se os valores de entrada forem inválidos.
 */
BitmapCrop( &pBitmap, crop ) {
	
	x := crop[ 1 ]
	y := crop[ 2 ]
	w := crop[ 3 ]
	w := crop[ 4 ]

	Aa := IsObject(crop)
	x1 := x ~= "^-?\d+(\.\d*)?%?$"
	y1 := y ~= "^-?\d+(\.\d*)?%?$"
	w1 := w ~= "^-?\d+(\.\d*)?%?$"
	h1 := h ~= "^-?\d+(\.\d*)?%?$"


	if ( !( Aa && x1 && y1 && w1 && h1 ) ) {
		throw Error("Valores de entrada inválidos.")
	}

	; Obter a largura, altura e formato de pixel do bitmap
	DllCall(
		"gdiplus\GdipGetImageWidth",
		"ptr", pBitmap,
		"uint*", &width := 0
	)

	DllCall(
		"gdiplus\GdipGetImageHeight",
		"ptr", pBitmap,
		"uint*", &height := 0
	)

	DllCall(
		"gdiplus\GdipGetImagePixelFormat",
		"ptr", pBitmap,
		"int*", &format := 0
	)

	; ; Ajustar coordenadas e dimensões para porcentagens, se aplicável
	( x ~= "%$" ) && x := SubStr( x, 1, -1 ) * 0.01 * width
	( y ~= "%$" ) && y := SubStr( y, 1, -1 ) * 0.01 * height
	( w ~= "%$" ) && w := SubStr( w, 1, -1 ) * 0.01 * width
	( h ~= "%$" ) && h := SubStr( h, 1, -1 ) * 0.01 * height

	; Garantir que os valores sejam positivos
	x := Abs( x )
	y := Abs( y )
	w := (w < 0 ) ? width - Abs( w ) - Abs( x ) : w
	h := ( h < 0 ) ? height - Abs( h ) - Abs( y ) : h

	; Arredondar para o inteiro mais próximo
	x := Round( x )
	y := Round( y )
	w := Round( x + w ) - Round( x )
	h := Round( y + h ) - Round( y )

	; Evitar o recorte se as dimensões forem zero
	if ( x = 0 && y = 0 && w == width && h == height ) {
		return pBitmap
	}

	; Minimum size is 1 x 1. Ensure that coordinates can never exceed the expected Bitmap area.
	safe_x := ( x >= width )
	safe_y := ( y >= height )
	safe_w := ( w <= 0 || x + w > width )
	safe_h := ( h <= 0 || y + h > height )

	; Abortar o recorte se os valores forem inseguros
	if ( safe_x || safe_y || safe_w || safe_h ) {
		return pBitmap
	}
	; Clonar e recortar o bitmap
	DllCall(
		"gdiplus\GdipCloneBitmapAreaI",
		"int", x,
		"int", y,
		"int", w,
		"int", h,
		"int", format,
		"ptr", pBitmap,
		"ptr*", &pBitmapCrop := 0
	)
	DllCall(
		"gdiplus\GdipDisposeImage",
		"ptr", pBitmap
	)

	pBitmap := pBitmapCrop

	return pBitmap
}