#Include ErroGdi.ahk

Layered_Window_ShutDown( This ) {
	SelectObject(This.hdc,This.obm)
	DeleteObject(This.hbm)
	DeleteDC(This.hdc)
	gdip_deleteGraphics(This.G)
}

UpdateLayeredWindow( hwnd, hdc, x := 0, y := 0, w := 0, h := 0, Alpha := 255 ) {
	
	if ( (x != 0 ) && ( y != 0 ) ) {
		pt := Buffer( 8, 0 )
		NumPut( "UInt", x, pt, 0 )
		NumPut( "UInt", y, pt, 4 )
	}

	if ( w = 0 ) ||( h = 0 ) {
		WinGetPos( , , &w, &h, "ahk_id " hwnd )
	}

	return DllCall("UpdateLayeredWindow"
					, "UPtr", hwnd
					, "UPtr", 0
					, "UPtr", ( ( x = 0) && ( y = 0 ) ) ? 0 : pt
					, "int64*", w|h<<32
					, "UPtr", hdc
					, "int64*", 0
					, "uint", 0
					, "UInt*", Alpha << 16 | 1 << 24
					, "uint", 2 )
}

/**
 * Desenha uma linha em um objeto gráfico GDI+.
 *
 * @param pGraphics Ponteiro para o objeto gráfico GDI+.
 * @param pPen Ponteiro para a caneta GDI+.
 * @param x1 Coordenada x do ponto inicial.
 * @param y1 Coordenada y do ponto inicial.
 * @param x2 Coordenada x do ponto final.
 * @param y2 Coordenada y do ponto final.
 * @return Resultado da chamada DllCall.
 */
Gdip_DrawLine( pGraphics, pPen, x1, y1, x2, y2) {
    Bool :=
    DllCall(
        "gdiplus\GdipDrawLine",
        "UPtr", pGraphics,
        "UPtr", pPen,
        "float", x1,
        "float", y1,
        "float", x2,
        "float", y2
    )

    return ErrorGdi( Bool, Gdip_DrawLine ) 
}

ErrorGdi( Bool, fn ) {
    Error := ErroGdi( Bool, fn )
    if ( Error.GdiErrors = 0 ) {
        Error := ""
        return Bool
    }
}


/**
 * Deleta um pincel GDI+.
 *
 * @param pBrush Ponteiro para o pincel GDI+.
 * @return Resultado da chamada DllCall.
 */
Gdip_DeleteBrush(pBrush) {
    return DllCall("gdiplus\GdipDeleteBrush", "UPtr", pBrush)
}


/**
 * Deleta uma caneta GDI+.
 *
 * @param pPen Ponteiro para a caneta GDI+.
 * @return Resultado da chamada DllCall.
 */
Gdip_DeletePen(pPen) {
    return DllCall("gdiplus\GdipDeletePen", "UPtr", pPen)
}


/**
 * Dispoe de uma imagem GDI+.
 *
 * @param pBitmap Ponteiro para o bitmap GDI+.
 * @return Resultado da chamada DllCall.
 */
Gdip_DisposeImage(pBitmap) {
    return DllCall("gdiplus\GdipDisposeImage", "UPtr", pBitmap)
}


/**
 * Finaliza uma janela em camadas.
 *
 * @param This Estrutura contendo informações da janela.
 */
/*
Layered_Window_ShutDown(This) {
    SelectObject(This.hdc, This.obm)
    DeleteObject(This.hbm)
    DeleteDC(This.hdc)
    Gdip_DeleteGraphics(This.g)
    Gdip_Shutdown(This.Token)
}

*/

/**
 * Deleta um objeto GDI.
 *
 * @param hObject Handle do objeto GDI.
 * @return Resultado da chamada DllCall.
 */
DeleteObject(hObject) {
    return DllCall("DeleteObject", "UPtr", hObject)
}


/**
 * Cria um bitmap GDI+.
 *
 * @param Width Largura do bitmap.
 * @param Height Altura do bitmap.
 * @param Format Formato do bitmap (padrão é 0x26200A).
 * @return Ponteiro para o bitmap criado.
 */
Gdip_CreateBitmap( Width, Height, Format := 0x26200A) {
	pBitmap := 0
    DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", 0, "int", Format, "UPtr", 0, "UPtr*", &pBitmap)
    return pBitmap
}


/**
 * Cria um objeto gráfico a partir de uma imagem GDI+.
 *
 * @param pBitmap Ponteiro para o bitmap GDI+.
 * @return Ponteiro para o objeto gráfico criado.
 */
Gdip_GraphicsFromImage(pBitmap) {
	pGraphics := 0
    DllCall("gdiplus\GdipGetImageGraphicsContext", "UPtr", pBitmap, "UPtr*", &pGraphics)
    return pGraphics
}


/**
 * Define o modo de suavização para um objeto gráfico GDI+.
 *
 * @param pGraphics Ponteiro para o objeto gráfico GDI+.
 * @param SmoothingMode Modo de suavização.
 * @return Resultado da chamada DllCall.
 */
Gdip_SetSmoothingMode(pGraphics, SmoothingMode) {
    return DllCall("gdiplus\GdipSetSmoothingMode", "UPtr", pGraphics, "int", SmoothingMode)
}


/**
 * Cria um novo pincel sólido GDI+.
 *
 * @param Colour Cor do pincel (padrão é "000000").
 * @param Alpha Valor alfa (padrão é "FF").
 * @return Ponteiro para o pincel criado.
 */
New_Brush(Colour := "000000", Alpha := "FF") {
    new_colour := "0x" Alpha Colour
    return Gdip_BrushCreateSolid(new_colour)
}


/**
 * Preenche um retângulo com um pincel GDI+.
 *
 * @param pGraphics Ponteiro para o objeto gráfico GDI+.
 * @param pBrush Ponteiro para o pincel GDI+.
 * @param x Coordenada x do retângulo.
 * @param y Coordenada y do retângulo.
 * @param w Largura do retângulo.
 * @param h Altura do retângulo.
 * @return Resultado da chamada DllCall.
 */
Fill_Box(pGraphics, pBrush, x, y, w, h) {
    return DllCall("gdiplus\GdipFillRectangle"
                    , "UPtr", pGraphics
                    , "UPtr", pBrush
                    , "float", x
                    , "float", y
                    , "float", w
                    , "float", h)
}


/**
 * Cria um pincel de linha gradiente GDI+ a partir de um retângulo.
 *
 * @param x Coordenada x do retângulo.
 * @param y Coordenada y do retângulo.
 * @param w Largura do retângulo.
 * @param h Altura do retângulo.
 * @param ARGB1 Cor inicial do gradiente.
 * @param ARGB2 Cor final do gradiente.
 * @param LinearGradientMode Modo do gradiente linear (padrão é 1).
 * @param WrapMode Modo de repetição (padrão é 1).
 * @return Ponteiro para o pincel de linha gradiente criado.
 */
Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode := 1, WrapMode := 1) {
    RectF := CreateRectF(x, y, w, h)
	LGpBrush := 0
    DllCall("gdiplus\GdipCreateLineBrushFromRect", "UPtr", RectF.Ptr, "int", ARGB1, "int", ARGB2, "int", LinearGradientMode, "int", WrapMode, "UPtr*", &LGpBrush)
    return LGpBrush
}



/**
 * Desenha texto em um objeto gráfico GDI+.
 *
 * @param pGraphics Ponteiro para o objeto gráfico GDI+.
 * @param Text O texto a ser desenhado.
 * @param Options Opções de formatação e posicionamento do texto.
 * @param Font A fonte do texto (padrão é "Arial").
 * @param Width A largura do texto (opcional).
 * @param Height A altura do texto (opcional).
 * @param Measure Se 1, apenas mede o texto sem desenhar (padrão é 0).
 * @return Retorna as dimensões do texto medido ou um código de erro.
 */
/*
Gdip_TextToGraphics( pGraphics, Text, Options, Font := "Arial", Width := 0, Height := 0, Measure := 0) {
    IWidth := Width, IHeight := Height

    RegExMatch(Options, "i)X([\-\d\.]+)(p*)", xpos)
    RegExMatch(Options, "i)Y([\-\d\.]+)(p*)", ypos)
    RegExMatch(Options, "i)W([\-\d\.]+)(p*)", Width)
    RegExMatch(Options, "i)H([\-\d\.]+)(p*)", Height)
    RegExMatch(Options, "i)C(?!(entre|enter))([a-f\d]+)", Colour)
    RegExMatch(Options, "i)Top|Up|Bottom|Down|vCentre|vCenter", vPos)
    RegExMatch(Options, "i)NoWrap", NoWrap)
    RegExMatch(Options, "i)R(\d)", Rendering)
    RegExMatch(Options, "i)S(\d+)(p*)", Size)

    if !Gdip_DeleteBrush( Gdip_CloneBrush(Colour2) ) {
        PassBrush := 1
		pBrush := Colour2
	}

    if !(IWidth && IHeight) && (xpos[2] || ypos[2] || Width[2] || Height[2] || Size[2])
        return -1

    Style := 0, Styles := ["Regular", "Bold", "Italic", "BoldItalic", "Underline", "Strikeout"]
    for index, name in Styles {
        if RegExMatch(Options, "\b" name)
            Style |= (name != "Strikeout") ? (index - 1) : 8
    }

    Align := 0, Alignments := ["Near", "Left", "Centre", "Center", "Far", "Right"]
    for index, name in Alignments {
        if RegExMatch(Options, "\b" name)
            Align := index // 2.1      ; 0|0|1|1|2|2
    }

    xpos := (xpos[1] != 0) ? (xpos[2] ? IWidth * (xpos[1] / 100) : xpos[1]) : 0
    ypos := (ypos[1] != 0) ? (ypos[2] ? IHeight * (ypos[1] / 100) : ypos[1]) : 0
    Width := Width[1] ? (Width[2] ? IWidth * (Width[1] / 100) : Width[1]) : IWidth
    Height := Height[1] ? (Height[2] ? IHeight * (Height[1] / 100) : Height[1]) : IHeight
    if !PassBrush
        Colour := "0x" (Colour[2] ? Colour[2] : "ff000000")
    Rendering := ((Rendering[1] >= 0) && (Rendering[1] <= 5)) ? Rendering[1] : 4
    Size := (Size[1] > 0) ? (Size[2] ? IHeight * (Size[1] / 100) : Size[1]) : 12

    hFamily := Gdip_FontFamilyCreate(Font)
    hFont := Gdip_FontCreate(hFamily, Size, Style)
    FormatStyle := NoWrap ? 0x4000 | 0x1000 : 0x4000
    hFormat := Gdip_StringFormatCreate(FormatStyle)
    pBrush := PassBrush ? pBrush : Gdip_BrushCreateSolid(Colour)
    if !(hFamily && hFont && hFormat && pBrush && pGraphics)
        return !pGraphics ? -2 : !hFamily ? -3 : !hFont ? -4 : !hFormat ? -5 : !pBrush ? -6 : 0

    RC := CreateRectF(xpos, ypos, Width, Height)
    Gdip_SetStringFormatAlign(hFormat, Align)
    Gdip_SetTextRenderingHint(pGraphics, Rendering)
    ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)

    if vPos {
        ReturnRC := StrSplit(ReturnRC, "|")

        if vPos = "vCentre" || vPos = "vCenter"
            ypos += (Height - ReturnRC[4]) // 2
        else if vPos = "Top" || vPos = "Up"
            ypos := 0
        else if vPos = "Bottom" || vPos = "Down"
            ypos := Height - ReturnRC[4]

        RC := CreateRectF(xpos, ypos, Width, ReturnRC[4])
        ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
    }

    if !Measure
        E := Gdip_DrawString(pGraphics, Text, hFont, hFormat, pBrush, RC)

    if !PassBrush
        Gdip_DeleteBrush(pBrush)
    Gdip_DeleteStringFormat(hFormat)
    Gdip_DeleteFont(hFont)
    Gdip_DeleteFontFamily(hFamily)
    return E ? E : ReturnRC
}
*/
/**
 * Cria um retângulo de layout (RectF).
 *
 * @param x Coordenada x do retângulo.
 * @param y Coordenada y do retângulo.
 * @param w Largura do retângulo.
 * @param h Altura do retângulo.
 * @return Buffer do retângulo criado.
 */
CreateRectF(x, y, w, h) {
    RectF := Buffer(16)
    NumPut("Float", x, RectF, 0)
    NumPut("Float", y, RectF, 4)
    NumPut("Float", w, RectF, 8)
    NumPut("Float", h, RectF, 12)
    return RectF
}



/**
 * Inicializa GDI+.
 *
 * @return Token GDI+ inicializado.
 */
/*
Gdip_Startup() {
    static hModule := DllCall("LoadLibrary", "Str", "gdiplus.dll", "Ptr")
    if !hModule
        return 0
    VarSetCapacity(si, 16, 0)
    DllCall("gdiplus\GdiplusStartup", "PtrP", pToken, "Ptr", &si, "Ptr", 0)
    return pToken
}
*/

/**
 * Finaliza GDI+.
 *
 * @param pToken Token GDI+ a ser finalizado.
 */
/*
Gdip_Shutdown(pToken) {
    DllCall("gdiplus\GdiplusShutdown", "Ptr", pToken)
}
*/
/**
 * Obtém a largura da imagem.
 *
 * @param pBitmap Ponteiro para o bitmap.
 * @return Largura da imagem.
 */
Gdip_GetImageWidth(pBitmap) {
	width := 0
    DllCall("gdiplus\GdipGetImageWidth", "UPtr", pBitmap, "UInt*", &width)
    return width
}

/**
 * Obtém a altura da imagem.
 *
 * @param pBitmap Ponteiro para o bitmap.
 * @return Altura da imagem.
 */
Gdip_GetImageHeight(pBitmap) {
	height := 0
    DllCall("gdiplus\GdipGetImageHeight", "UPtr", pBitmap, "UInt*", &height)
    return height
}
/* Chat 001

/**
 * Desenha texto em um objeto gráfico GDI+.
 *
 * @param pGraphics Ponteiro para o objeto gráfico GDI+.
 * @param Text O texto a ser desenhado.
 * @param Options Opções de formatação e posicionamento do texto.
 * @param Font A fonte do texto (padrão é "Arial").
 * @param Width A largura do texto (opcional).
 * @param Height A altura do texto (opcional).
 * @param Measure Se 1, apenas mede o texto sem desenhar (padrão é 0).
 * @return Retorna as dimensões do texto medido ou um código de erro.
 */
/*
Gdip_TextToGraphics(pGraphics, Text, Options, Font := "Arial", Width := 0, Height := 0, Measure := 0) {
    IWidth := Width, IHeight := Height

    RegExMatch(Options, "i)X([\-\d\.]+)(p*)", xpos)
    RegExMatch(Options, "i)Y([\-\d\.]+)(p*)", ypos)
    RegExMatch(Options, "i)W([\-\d\.]+)(p*)", Width)
    RegExMatch(Options, "i)H([\-\d\.]+)(p*)", Height)
    RegExMatch(Options, "i)C(?!(entre|enter))([a-f\d]+)", Colour)
    RegExMatch(Options, "i)Top|Up|Bottom|Down|vCentre|vCenter", vPos)
    RegExMatch(Options, "i)NoWrap", NoWrap)
    RegExMatch(Options, "i)R(\d)", Rendering)
    RegExMatch(Options, "i)S(\d+)(p*)", Size)

    if !Gdip_DeleteBrush(Gdip_CloneBrush(Colour2))
        PassBrush := 1, pBrush := Colour2

    if !(IWidth && IHeight) && (xpos2 || ypos2 || Width2 || Height2 || Size2)
        return -1

    Style := 0, Styles := "Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
    Loop, Parse, Styles, |
    {
        if RegExMatch(Options, "\b" A_LoopField)
            Style |= (A_LoopField != "StrikeOut") ? (A_Index-1) : 8
    }

    Align := 0, Alignments := "Near|Left|Centre|Center|Far|Right"
    Loop, Parse, Alignments, |
    {
        if RegExMatch(Options, "\b" A_LoopField)
            Align |= A_Index//2.1      ; 0|0|1|1|2|2
    }

    xpos := (xpos1 != 0) ? xpos2 ? IWidth*(xpos1/100) : xpos1 : 0
    ypos := (ypos1 != 0) ? ypos2 ? IHeight*(ypos1/100) : ypos1 : 0
    Width := Width1 ? Width2 ? IWidth*(Width1/100) : Width1 : IWidth
    Height := Height1 ? Height2 ? IHeight*(Height1/100) : Height1 : IHeight
    if !PassBrush
        Colour := "0x" (Colour2 ? Colour2 : "ff000000")
    Rendering := ((Rendering1 >= 0) && (Rendering1 <= 5)) ? Rendering1 : 4
    Size := (Size1 > 0) ? Size2 ? IHeight*(Size1/100) : Size1 : 12

    hFamily := Gdip_FontFamilyCreate(Font)
    hFont := Gdip_FontCreate(hFamily, Size, Style)
    FormatStyle := NoWrap ? 0x4000 | 0x1000 : 0x4000
    hFormat := Gdip_StringFormatCreate(FormatStyle)
    pBrush := PassBrush ? pBrush : Gdip_BrushCreateSolid(Colour)
    if !(hFamily && hFont && hFormat && pBrush && pGraphics)
        return !pGraphics ? -2 : !hFamily ? -3 : !hFont ? -4 : !hFormat ? -5 : !pBrush ? -6 : 0

    CreateRectF(RC, xpos, ypos, Width, Height)
    Gdip_SetStringFormatAlign(hFormat, Align)
    Gdip_SetTextRenderingHint(pGraphics, Rendering)
    ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)

    if vPos {
        StringSplit, ReturnRC, ReturnRC, |

        if (vPos = "vCentre") || (vPos = "vCenter")
            ypos += (Height-ReturnRC4)//2
        else if (vPos = "Top") || (vPos = "Up")
            ypos := 0
        else if (vPos = "Bottom") || (vPos = "Down")
            ypos := Height-ReturnRC4

        CreateRectF(RC, xpos, ypos, Width, ReturnRC4)
        ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
    }

    if !Measure
        E := Gdip_DrawString(pGraphics, Text, hFont, hFormat, pBrush, RC)

    if !PassBrush
        Gdip_DeleteBrush(pBrush)
    Gdip_DeleteStringFormat(hFormat)
    Gdip_DeleteFont(hFont)
    Gdip_DeleteFontFamily(hFamily)
    return E ? E : ReturnRC
}
*/



/**
 *  pGraphics: Ponteiro para o objeto gráfico GDI+ no qual a imagem será desenhada.
 *  pBitmap: Ponteiro para o bitmap GDI+ que será desenhado.
 *  dx, dy: Coordenadas de destino no objeto gráfico onde a imagem será desenhada.
 *  dw, dh: Dimensões de destino da imagem desenhada.
 *  sx, sy: Coordenadas de origem na imagem original (bitmap) de onde a imagem será copiada.
 *  sw, sh: Dimensões da seção da imagem original que será copiada.
 *  Matrix: Matriz de transformação de cores ou valor 1 para nenhuma transformação. Pode ser uma matriz customizada ou um valor para ajuste de opacidade.
 * 
 */


Gdip_DrawImage(pGraphics, pBitmap, dx := 0, dy := 0, dw := 0, dh := 0, sx := 0, sy := 0, sw := 0, sh := 0, Matrix := 0) { ;Chat
    ; Configura os atributos de imagem, se necessário
    ImageAttr := 0
    if IsObject(Matrix) {
        ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
    }

    ; Define as coordenadas e dimensões padrão, se não fornecidas
    if (sx = 0 && sy = 0 && sw = 0 && sh = 0) {
        if (dx = 0 && dy = 0 && dw = 0 && dh = 0) {
            ; Origem e destino são a imagem inteira
            dx := dy := sx := sy := 0
            dw := sw := Gdip_GetImageWidth(pBitmap)
            dh := sh := Gdip_GetImageHeight(pBitmap)
        } else {
            ; Origem é a imagem inteira
            sx := sy := 0
            sw := Gdip_GetImageWidth(pBitmap)
            sh := Gdip_GetImageHeight(pBitmap)
        }
    }

    ; Chama a função GdipDrawImageRectRect para desenhar a imagem
    E := DllCall("gdiplus\GdipDrawImageRectRect"
                 , "UPtr", pGraphics
                 , "UPtr", pBitmap
                 , "float", dx
                 , "float", dy
                 , "float", dw
                 , "float", dh
                 , "float", sx
                 , "float", sy
                 , "float", sw
                 , "float", sh
                 , "int", 2
                 , "UPtr", ImageAttr
                 , "UPtr", 0
                 , "UPtr", 0)

    ; Libera os atributos de imagem, se criados
    if ImageAttr
        Gdip_DisposeImageAttributes(ImageAttr)

    return E
}


/*
Gdip_DrawImage( pGraphics, pBitmap, dx := 0, dy := 0, dw := 0, dh := 0, sx := 0, sy := 0, sw := 0, sh := 0, Matrix := 1 )
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if (Matrix&1 = 0)
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")

	if (sx = 0 && sy = 0 && sw = 0 && sh = 0)
	{
		if (dx = 0 && dy = 0 && dw = 0 && dh = 0)
		{
			sx := dx := 0, sy := dy := 0
			sw := dw := Gdip_GetImageWidth(pBitmap)
			sh := dh := Gdip_GetImageHeight(pBitmap)
		}
		else
		{
			sx := sy := 0
			sw := Gdip_GetImageWidth(pBitmap)
			sh := Gdip_GetImageHeight(pBitmap)
		}
	}

	E := DllCall("gdiplus\GdipDrawImageRectRect"
				, Ptr, pGraphics
				, Ptr, pBitmap
				, "float", dx
				, "float", dy
				, "float", dw
				, "float", dh
				, "float", sx
				, "float", sy
				, "float", sw
				, "float", sh
				, "int", 2
				, Ptr, ImageAttr
				, Ptr, 0
				, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return E
}
*/
Gdip_DeleteGraphics(pGraphics)
{
   return DllCall("gdiplus\GdipDeleteGraphics", "UPtr", pGraphics)
}

;Gdip_SetSmoothingMode( pGraphics, SmoothingMode) {
;
;   return DllCall( "gdiplus\GdipSetSmoothingMode", "UPtr", pGraphics, "int", SmoothingMode )
;}


Gdip_GraphicsClear( pGraphics, ARGB := 0x00ffffff ) {
    Bool := 
    DllCall(
        "gdiplus\GdipGraphicsClear",
        "UPtr", pGraphics,
        "int", ARGB
    )

    if ( ErrorGdi( Bool, Gdip_GraphicsClear ) ) {
        return Bool
    }
}

SelectObject( hdc, hgdiobj ) {
    rHGDIOBJ := 
	DllCall(
        "SelectObject",
        "UPtr", hdc,
        "UPtr", hgdiobj
    )
    if ( rHGDIOBJ = -1) {
        Throw( "Erro ao criar o bitmap." )
    }
    return rHGDIOBJ
}

DeleteDC( hdc ) {
    Bool :=
    DllCall(    
        "DeleteDC",
        "UPtr", hdc
    )

    if ( Bool ) {
        return Bool
    }
    Throw( "Erro ao deletar DC")
}
/*
Gdip_Shutdown( pToken ) {
	Ptr := "UPtr"

	DllCall( "gdiplus\GdiplusShutdown", "UPtr", pToken )
	if hModule := DllCall( "GetModuleHandle", "str", "gdiplus", "UPtr" )
		DllCall( "FreeLibrary", "UPtr", hModule )
	return 0
}
*/
Gdip_BrushCreateSolid( ARGB :=  0xff000000 ) {
	pBrush := 0
	DllCall( "gdiplus\GdipCreateSolidFill", "UInt", ARGB, "UPtr*", pBrush )
	return pBrush
}
/*
CreateRectF( &RectF, x, y, w, h ) {
    RectF := Buffer(16)
    NumPut("Float", x, RectF, 0)
    NumPut("Float", y, RectF, 4)
    NumPut("Float", w, RectF, 8)
    NumPut("Float", h, RectF, 12)
}
*/
Gdip_CloneBrush( pBrush ) {
	pBrushClone := 0
	DllCall( "gdiplus\GdipCloneBrush", "UPtr", pBrush, "UPtr*", pBrushClone )
	return pBrushClone
}
Gdip_FontFamilyCreate( Font  ) {
	hFamily := 0

	DllCall( "gdiplus\GdipCreateFontFamilyFromName"
					, "UPtr", &Font
					, "uint", 0
					, "UPtr*", hFamily )

	return hFamily
}
Gdip_FontCreate( hFamily, Size, Style := 0  ) {
	hFont := 0
   	DllCall( "gdiplus\GdipCreateFont", "UPtr", hFamily, "float", Size, "int", Style, "int", 0, "UPtr*", hFont  )
   	return hFont
}
Gdip_StringFormatCreate( Format := 0, Lang := 0 ) {
	hFormat := 
   	DllCall( "gdiplus\GdipCreateStringFormat", "int", Format, "int", Lang, "UPtr*", hFormat )
   	return hFormat
}
Gdip_SetStringFormatAlign( hFormat, Align ) {
   return DllCall( "gdiplus\GdipSetStringFormatAlign", "UPtr", hFormat, "int", Align )
}
Gdip_SetTextRenderingHint( pGraphics, RenderingHint ) {
	return DllCall( "gdiplus\GdipSetTextRenderingHint", "UPtr", pGraphics, "int", RenderingHint )
}

Gdip_MeasureString( pGraphics, sString, hFont, hFormat, &RectF ) {
    ; Cria um buffer para o retângulo de medição
	Lines := 0
	Chars := 0
    RC := Buffer(16, 0)

    ; Chama a função GdipMeasureString para medir a string
    result := DllCall("gdiplus\GdipMeasureString"
                    , "UPtr", pGraphics  ; Ponteiro para o objeto gráfico
                    , "WStr", sString    ; String a ser medida
                    , "int", -1          ; Comprimento da string, -1 para medir até o fim da string
                    , "UPtr", hFont      ; Ponteiro para a fonte
                    , "UPtr", RectF      ; Ponteiro para o retângulo de layout
                    , "UPtr", hFormat    ; Ponteiro para o formato da string
                    , "UPtr", RC.Ptr     ; Ponteiro para o retângulo resultante
                    , "UInt*", Chars     ; Ponteiro para o número de caracteres
                    , "UInt*", Lines     ; Ponteiro para o número de linhas
                    )

    ; Se a medição foi bem-sucedida, extrai as dimensões do retângulo resultante
    if (result == 0) {
        width := NumGet(RC, 0, "float")
        height := NumGet(RC, 4, "float")
        right := NumGet(RC, 8, "float")
        bottom := NumGet(RC, 12, "float")

        return width "|" height "|" right "|" bottom "|" Chars "|" Lines
    } else {
        return 0
    }
}


/*
Gdip_MeasureString( pGraphics, sString, hFont, hFormat, ByRef RectF ) {
	
	DllCall( "gdiplus\GdipMeasureString"
					, "UPtr", pGraphics
					, "UPtr", &sString
					, "int", -1
					, "UPtr", hFont
					, "UPtr", &RectF
					, "UPtr", hFormat
					, "UPtr", &RC
					, "uint*", Chars
					, "uint*", Lines )

	return &RC ? NumGet( RC, 0, "float" ) "|" NumGet( RC, 4, "float" ) "|" NumGet( RC, 8, "float" ) "|" NumGet( RC, 12, "float" ) "|" Chars "|" Lines : 0
}
*/
Gdip_DrawString( pGraphics, sString, hFont, hFormat, pBrush, &RectF) {
    return DllCall("gdiplus\GdipDrawString"
                   , "UPtr", pGraphics
                   , "WStr", sString
                   , "int", -1
                   , "UPtr", hFont
                   , "UPtr", RectF
                   , "UPtr", hFormat
                   , "UPtr", pBrush)
}

/*
Gdip_DrawString( pGraphics, sString, hFont, hFormat, pBrush, &RectF ) {

	return DllCall( "gdiplus\GdipDrawString"
					, "UPtr", pGraphics
					, "UPtr", &sString
					, "int", -1
					, "UPtr", hFont
					, "UPtr", &RectF
					, "UPtr", hFormat
					, "UPtr", pBrush )
}
*/
Gdip_DeleteStringFormat( hFormat ) {
   return DllCall( "gdiplus\GdipDeleteStringFormat", "UPtr", hFormat )
}
Gdip_DeleteFont( hFont ) {
   return DllCall( "gdiplus\GdipDeleteFont", "UPtr", hFont )
}
Gdip_DeleteFontFamily( hFamily ) {
   return DllCall( "gdiplus\GdipDeleteFontFamily", "UPtr", hFamily )
}

Gdip_SetImageAttributesColorMatrix( Matrix ) { ; Chat

    ColourMatrix := Buffer ( 100, 0 )

	Loop 5 {
        row := A_Index - 1
        Loop 5 {
            col := A_Index - 1
            Value := Matrix[row, col]
            NumPut( "Float", Value, ColourMatrix, (row * 5 + col) * 4 )
        }
    }

    DllCall("gdiplus\GdipCreateImageAttributes", "UPtr*", &ImageAttr)
    DllCall("gdiplus\GdipSetImageAttributesColorMatrix", "UPtr", ImageAttr, "int", 1, "int", 1, "UPtr", ColourMatrix.Ptr, "UPtr", 0, "int", 0)
    return ImageAttr
}


/*
Gdip_SetImageAttributesColorMatrix( Matrix ) {
	
	VarSetCapacity( ColourMatrix, 100, 0 )
	
	Matrix := RegExReplace( RegExReplace( Matrix, "^[^\d-\.]+( [\d\.] )", "$1", "", 1 ), "[^\d-\.]+", "|" )
	StringSplit, Matrix, Matrix, |
	Loop, 25 {
		Matrix := ( Matrix%A_Index% != 0 ) ? Matrix%A_Index% : Mod( A_Index-1, 6 ) ? 0 : 1
		NumPut( Matrix, ColourMatrix, ( A_Index-1 )*4, "float" )
	}
	DllCall( "gdiplus\GdipCreateImageAttributes", "UPtr*", ImageAttr )
	DllCall( "gdiplus\GdipSetImageAttributesColorMatrix", "UPtr", ImageAttr, "int", 1, "int", 1, "UPtr", &ColourMatrix, "UPtr", 0, "int", 0 )
	return ImageAttr
}
*/

/*

Gdip_GetImageWidth( pBitmap ) {
	Width := 0
   DllCall( "gdiplus\GdipGetImageWidth", "UPtr", pBitmap, "uint*", Width )
   return Width
}


Gdip_GetImageHeight( pBitmap ) {
	Height := 0
   DllCall( "gdiplus\GdipGetImageHeight", "UPtr", pBitmap, "uint*", Height )
   return Height
}

*/

Gdip_DisposeImageAttributes( ImageAttr ) {
	return DllCall( "gdiplus\GdipDisposeImageAttributes", "UPtr", ImageAttr )
}

New_Pen(colour:="000000",Alpha:="FF",Width:= 5)
{
	;~ static Hellbent_Pen:=[]
	new_colour := "0x" Alpha colour
	;~ Hellbent_Pen[Hellbent_Pen.Length()+1]:=Gdip_CreatePen(New_Colour,Width)
	return Gdip_CreatePen( New_Colour,Width )
}

CreateDIBSection( w, h, hdc := 0, bpp := 32, &ppvBits := 0 ) {
	
	hdc2 := hdc ? hdc : GetDC( )

	BI := Buffer( 40, 0 )

	NumPut( "UInt", w, bi, 4 )
	, NumPut( "UInt", h, bi, 8 )
	, NumPut( "UInt", 40, bi, 0 )
	, NumPut( "UShort", 1, bi, 12 )
	, NumPut( "UInt", 0, bi, 16 )
	, NumPut( "UShort", bpp, bi, 14 )

	;DllCall("CreateDIBSection", "uptr", hdc2, "uptr", &bi, "uint", 0, "uptr*", ppvBits, "uptr", 0, "uint", 0)
	hbm := DllCall( "CreateDIBSection",
					"Ptr", hdc2,
					"UPtr", bi.Ptr,
					"uint", 0,
					"UPtr*", ppvBits,
					"UPtr", 0,
					"uint", 0,
					"UPtr" )

	if ( !hdc ) {
		ReleaseDC( hdc2 )
	}

	return hbm
}
CreateCompatibleDC( hdc := 0 ) {
    mDC :=
    DllCall(
        "CreateCompatibleDC",
        "Ptr", hdc
    )
    return mDC
}
Gdip_GraphicsFromHDC( hdc ) {
	pGraphics := 0
    Bool :=
    DllCall(
        "gdiplus\GdipCreateFromHDC",
        "UPtr", hdc,
        "UPtr*", &pGraphics
    )

    if ( !ErrorGdi( Bool, Gdip_GraphicsFromHDC ) ) {
        return pGraphics
    }
     
}
Gdip_CreatePen( ARGB, w ) {
    pPen := 0
    Bool :=
    DllCall(
        "gdiplus\GdipCreatePen1",
        "UInt", ARGB,
        "float", w,
        "int", 2,
        "UPtr*", &pPen
    )

    if ( !ErrorGdi( Bool, Gdip_CreatePen ) ) {
        return pPen
    }
}
Gdip_GetClipRegion( pGraphics ) {
	Region := Gdip_CreateRegion( )
	DllCall( "gdiplus\GdipGetClip", "UPtr", pGraphics, "UInt*", Region )
	return Region
}
Gdip_SetClipRect( pGraphics, x, y, w, h, CombineMode := 0 ) {
   return DllCall( "gdiplus\GdipSetClipRect",  "UPtr", pGraphics, "float", x, "float", y, "float", w, "float", h, "int", CombineMode )
}
Gdip_FillRectangle( pGraphics, pBrush, x, y, w, h ) {
	Ptr := "UPtr"

	return DllCall( "gdiplus\GdipFillRectangle"
					, Ptr, pGraphics
					, Ptr, pBrush
					, "float", x
					, "float", y
					, "float", w
					, "float", h )
}
Gdip_SetClipRegion( pGraphics, Region, CombineMode := 0 ) {

	return DllCall( "gdiplus\GdipSetClipRegion", "UPtr", pGraphics, "UPtr", Region, "int", CombineMode )
}
Gdip_DeleteRegion( Region ) {
	return DllCall( "gdiplus\GdipDeleteRegion", "UPtr", Region )
}
Gdip_ResetClip( pGraphics ) {
   return DllCall( "gdiplus\GdipResetClip", "UPtr", pGraphics )
}
Gdip_DrawEllipse( pGraphics, pPen, x, y, w, h ) {

	return DllCall( "gdiplus\GdipDrawEllipse", "UPtr", pGraphics, "UPtr", pPen, "float", x, "float", y, "float", w, "float", h )
}
GetDC( hwnd := 0 ) {
	
    hdc :=
    DllCall( 
        "GetDC", 
        "Ptr", hwnd,
        "Ptr" 
    )
    return hdc
}
ReleaseDC( hdc, hwnd := 0 ) {

	return DllCall( "ReleaseDC", "UPtr", hwnd, "Ptr", hdc )
}
Gdip_CreateRegion( ) {
	Region := 0
	DllCall( "gdiplus\GdipCreateRegion", "UInt*", Region )
	return Region
}