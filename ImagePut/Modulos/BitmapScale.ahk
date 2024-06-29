#Include Includes.ahk
/**
 * Escala um bitmap com base no fator de escala ou nas dimensões especificadas.
 * 
 * @param {ptr} &pBitmap - Um ponteiro para o bitmap original.
 * @param {number|object} scale - Fator de escala ou objeto contendo as novas dimensões [largura, altura].
 * @param {int} direction - Direção de escalonamento (0 = sem direção, 1 = forçar upscaling, -1 = forçar downscaling).
 * @returns {ptr} - Um ponteiro para o novo bitmap escalado.
 * @examples 
 * 
 * -
 * ; Definir o bitmap original (exemplo)
 * pBitmap := SomeFunctionToLoadBitmap()
 * 
 * ; Definir o objeto scale com as novas dimensões
 * scale := {1: 800, 2: 600}
 * 
 * ; Chamar a função BitmapScale com scale como objeto
 * BitmapScale(pBitmap, scale)
 * 
 * ; O bitmap pBitmap agora foi redimensionado para 800x600 pixels
 * 
 * 
 * -
 * ; Definir o bitmap original (exemplo)
 * pBitmap := SomeFunctionToLoadBitmap()
 * 
 * ; Definir o fator de escala como 0.5 (50% do tamanho original)
 * scale := 0.5
 * 
 * ; Chamar a função BitmapScale com scale como número
 * BitmapScale(pBitmap, scale)
 * 
 * ; O bitmap pBitmap agora foi redimensionado para 50% do seu tamanho original
 * 
 * 
 */
BitmapScale(&pBitmap, scale, direction := 0) {
   ; Verificar a validade do parâmetro de escala

   if !(IsObject(scale) && (scale.HasKey(1) && scale.HasKey(2) && (scale[1] ~= "^\d+$" || scale[2] ~= "^\d+$")) || (scale ~= "^\d+(\.\d+)?$")) {
      throw Error("Escala inválida.")
   }

   ; Obter a largura, altura e formato do bitmap
   width := GdipGetImageWidth(pBitmap)
   height := GdipGetImageHeight(pBitmap)
   pformat := GdipGetImagePixelFormat(pBitmap)

   switch {
      case IsObject(scale):
         safe_w := scale[1] ~= "^\d+$"
         switch  {
            case safe_w :
               safe_w := scale[ 1 ]
            default:
               safe_w := Round( width / height * scale[ 2 ] )
         }
         safe_h := scale[2] ~= "^\d+$"
         switch  {
            case safe_h :
               safe_h := scale[ 2 ]
            default:
               safe_h := Round( width / height * scale[ 1 ] )
         }
      case !IsObject(scale):
         safe_w := Ceil(width * scale)
         safe_h := Ceil(height * scale)
      case safe_w = width && safe_h = height:
         return pBitmap
      case direction > 0 && (safe_w < width && safe_h < height):
   }

   ; Calcular as novas dimensões
   if IsObject(scale) {
      safe_w := (scale[1] ~= "^\d+$") ? scale[1] : Round(width / height * scale[2])
      safe_h := (scale[2] ~= "^\d+$") ? scale[2] : Round(height / width * scale[1])
   }
   else {
      safe_w := Ceil(width * scale)
      safe_h := Ceil(height * scale)
   }

   ; Evitar redimensionamento se não houver mudanças
   if (safe_w = width && safe_h = height) {
      return pBitmap
   }

   ; Forçar upscaling
   if (direction > 0 && (safe_w < width && safe_h < height)) {
      return pBitmap
   }

   ; Forçar downscaling
   if (direction < 0 && (safe_w > width && safe_h > height)) {
      return pBitmap
   }

   ; Criar um novo bitmap redimensionado
   stride := 0
   pBitmapScale := GdipCreateBitmapFromScan0(safe_w, safe_h, pformat, &pBitmapScale, stride)
   pGraphics := GdipGetImageGraphicsContext(pBitmapScale)


   ; Configurar o contexto gráfico
   PixelOffsetMode :=
      GdipSetPixelOffsetMode(pGraphics, 2) ; Half pixel offset
   CompositingMode :=
      GdipSetCompositingMode(pGraphics, 1) ; Overwrite/SourceCopy
   InterpolationMode :=
      GdipSetInterpolationMode(pGraphics, 7) ; HighQualityBicubic

   ; Desenhar a imagem redimensionada
   ImageAttr := GdipCreateImageAttributes()
   GdipSetImageAttributesWrapMode(
      ImageAttr,
      wrpMode := 3,
      argb := 0,
      clamp := 0
   )
   GdipDrawImageRectRectI(
      pGraphics, pBitmap,
      dstX := 0, dstY := 0, dstWidth := safe_w, destHeight := safe_h,
      srcX := 0, srcY := 0, srcWidth := width, srcHeigth := height, srcUnit := 2,
      ImageAttr,
      callback := 0, callbackData := 0
   )
   GdipDisposeImageAttributes(ImageAttr)

   ; Limpar o contexto gráfico
   GdipDeleteGraphics(pGraphics)
   GdipDisposeImage(pBitmap)

   ; Retornar o novo bitmap escalado
   pBitmap := pBitmapScale
   return pBitmap
}
/*
Descrição detalhada da função:
Parâmetros:

pBitmap: Um ponteiro para o bitmap original.
scale: Fator de escala (como número) ou um objeto contendo as novas dimensões [largura, altura].
direction: Direção de escalonamento (0 = sem direção, 1 = forçar upscaling, -1 = forçar downscaling).
Validação do Parâmetro de Escala:

Verifica se scale é um objeto com chaves válidas ou um número.
O objeto scale deve ter as chaves 1 e 2, representando a largura e a altura, respectivamente, e seus valores devem ser números válidos.
Obter Propriedades do Bitmap Original:

Usa chamadas DllCall para obter a largura, altura e formato de pixel do bitmap.
Calcular as Novas Dimensões:

Se scale for um objeto, calcula safe_w e safe_h com base nas dimensões fornecidas.
Se scale for um número, calcula safe_w e safe_h como uma fração da largura e altura originais.
Verificação de Redimensionamento:

Evita redimensionamento se as dimensões calculadas forem iguais às originais.
Força upscaling ou downscaling com base no parâmetro direction.
Criar um Novo Bitmap Redimensionado:

Usa DllCall para criar um novo bitmap com as dimensões calculadas e configurar o contexto gráfico.
Desenhar a Imagem Redimensionada:

Desenha a imagem redimensionada no novo bitmap, aplicando configurações de alta qualidade para o redimensionamento.
Limpar Recursos:

Limpa o contexto gráfico e libera o bitmap original.
Retorno:

Atualiza pBitmap para apontar para o novo bitmap redimensionado e retorna o ponteiro.
Esta função redimensiona um bitmap de acordo com o fator de escala ou dimensões especificadas, usando a API GDI+ do Windows para garantir alta qualidade no redimensionamento.

/*
BitmapScale(&pBitmap, scale, direction := 0) {
   if not (IsObject(scale) && ((scale[1] ~= "^\d+$") || (scale[2] ~= "^\d+$")) || (scale ~= "^\d+(\.\d+)?$"))
      throw Error("Invalid scale.")

   ; Get Bitmap width, height, and format.
   DllCall("gdiplus\GdipGetImageWidth", "ptr", pBitmap, "uint*", &width := 0)
   DllCall("gdiplus\GdipGetImageHeight", "ptr", pBitmap, "uint*", &height := 0)
   DllCall("gdiplus\GdipGetImagePixelFormat", "ptr", pBitmap, "int*", &format := 0)

   if IsObject(scale) {
      safe_w := (scale[1] ~= "^\d+$") ? scale[1] : Round(width / height * scale[2])
      safe_h := (scale[2] ~= "^\d+$") ? scale[2] : Round(height / width * scale[1])
   } else {
      safe_w := Ceil(width * scale)
      safe_h := Ceil(height * scale)
   }

   ; Avoid drawing if no changes detected.
   if (safe_w = width && safe_h = height)
      return pBitmap

   ; Force upscaling.
   if (direction > 0 and (safe_w < width && safe_h < height))
      return pBitmap

   ; Force downscaling.
   if (direction < 0 and (safe_w > width && safe_h > height))
      return pBitmap

   ; Create a destination GDI+ Bitmap that owns its memory.
   DllCall("gdiplus\GdipCreateBitmapFromScan0"
      , "int", safe_w, "int", safe_h, "int", 0, "int", format, "ptr", 0, "ptr*", &pBitmapScale := 0)
   DllCall("gdiplus\GdipGetImageGraphicsContext", "ptr", pBitmapScale, "ptr*", &pGraphics := 0)

   ; Set settings in graphics context.
   DllCall("gdiplus\GdipSetPixelOffsetMode", "ptr", pGraphics, "int", 2) ; Half pixel offset.
   DllCall("gdiplus\GdipSetCompositingMode", "ptr", pGraphics, "int", 1) ; Overwrite/SourceCopy.
   DllCall("gdiplus\GdipSetInterpolationMode", "ptr", pGraphics, "int", 7) ; HighQualityBicubic

   ; Draw Image.
   DllCall("gdiplus\GdipCreateImageAttributes", "ptr*", &ImageAttr := 0)
   DllCall("gdiplus\GdipSetImageAttributesWrapMode", "ptr", ImageAttr, "int", 3, "uint", 0, "int", 0) ; WrapModeTileFlipXY
   DllCall("gdiplus\GdipDrawImageRectRectI"
      , "ptr", pGraphics
      , "ptr", pBitmap
      , "int", 0, "int", 0, "int", safe_w, "int", safe_h ; destination rectangle
      , "int", 0, "int", 0, "int", width, "int", height ; source rectangle
      , "int", 2
      , "ptr", ImageAttr
      , "ptr", 0
      , "ptr", 0)
   DllCall("gdiplus\GdipDisposeImageAttributes", "ptr", ImageAttr)

   ; Clean up the graphics context.
   DllCall("gdiplus\GdipDeleteGraphics", "ptr", pGraphics)
   DllCall("gdiplus\GdipDisposeImage", "ptr", pBitmap)

   return pBitmap := pBitmapScale
}*/
