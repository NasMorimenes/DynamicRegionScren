/*
 * Function: Gdip_SetSmoothingMode
 * -------------------------------
 * Define o modo de suavização (antialiasing) para um objeto gráfico GDI+.
 *
 * Parameters:
 *   pGraphics - O ponteiro para o objeto gráfico GDI+.
 *   SmoothingMode - O modo de suavização a ser definido. Os valores possíveis são:
 *     - 0: SmoothingModeDefault
 *     - 1: SmoothingModeHighSpeed
 *     - 2: SmoothingModeHighQuality
 *     - 3: SmoothingModeNone
 *     - 4: SmoothingModeAntiAlias
 *
 * Returns:
 *   int - Retorna 0 se a função for bem-sucedida; caso contrário, um código de erro.
 *
 * Description:
 *   A função `Gdip_SetSmoothingMode` define o modo de suavização (antialiasing)
 *   para o objeto gráfico especificado por `pGraphics`. O modo de suavização
 *   determina a qualidade do desenho, com opções para alta velocidade, alta qualidade,
 *   nenhum antialiasing, ou antialiasing padrão.
 */
Gdip_SetSmoothingMode( pGraphics, SmoothingMode ) {
    bool :=
    DllCall(
        "gdiplus\GdipSetSmoothingMode",
        "Ptr", pGraphics,
        "Int", SmoothingMode,
        "Int"
    )
    return bool
}
