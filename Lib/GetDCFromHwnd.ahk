#Include GetDC.ahk
#Include GetDesktopWindow.ahk
/*
 * Function: GetDCFromHwnd
 * -----------------------
 * Obtém o contexto de dispositivo (DC) a partir do identificador da janela (hwnd).
 *
 * Parameters:
 *   hwnd (opcional) - O identificador da janela. Se não fornecido, obtém o DC da janela ativa.
 *
 * Returns:
 *   hdc - O identificador do contexto de dispositivo (DC) da janela.
 *
 * Description:
 *   A função `GetDCFromHwnd` verifica se um identificador da janela (hwnd) foi fornecido. Se não,
 *   obtém o DC da janela ativa ou da área de trabalho. Retorna o contexto de dispositivo (DC)
 *   correspondente.
 */
GetDCFromHwnd(hwnd := 0) {
    ; Se hwnd não for fornecido, obtém o DC da janela ativa
    if hwnd = 0 {
        hwnd := WinExist()   ; Obtém o identificador da janela ativa
    }
    
    ; Se hwnd ainda for 0, obtém o DC da área de trabalho
    if hwnd = 0 {
        hwnd := GetDesktopWindow()
    }

    ; Obtém o DC da janela especificada ou da área de trabalho
    hdc := GetDC(hwnd)
    return hdc
}

/*ChatGPT
Função: GetDCFromHwnd
Descrição:

A função GetDCFromHwnd verifica se um identificador da janela (hwnd) foi fornecido. Se não, obtém o DC da janela ativa ou da área de trabalho. Retorna o contexto de dispositivo (DC) correspondente.
Parâmetros:

hwnd (opcional): O identificador da janela. Se não fornecido, obtém o DC da janela ativa ou da área de trabalho.
Retorno:

hdc: O identificador do contexto de dispositivo (DC) da janela.
Detalhes de Implementação:

if hwnd = 0 { hwnd := WinExist() }: Se hwnd não for fornecido, obtém o identificador da janela ativa.
if hwnd = 0 { hwnd := DllCall("GetDesktopWindow", "ptr") }: Se hwnd ainda for 0, obtém o identificador da janela da área de trabalho.
hdc := GetDC(hwnd): Obtém o DC da janela especificada ou da área de trabalho.
return hdc: Retorna o contexto de dispositivo (DC).
Função: GetDC
Descrição:

A função GetDC obtém o contexto de dispositivo (DC) para a janela especificada por hwnd. O contexto de dispositivo é um objeto que define um conjunto de atributos gráficos e os modos de saída gráfica para o dispositivo de exibição. Esta função é usada para realizar operações de desenho em uma janela específica.
Parâmetros:

hwnd: O identificador da janela cuja DC deve ser obtida.
Retorno:

hdc: O identificador do contexto de dispositivo da janela especificada. Retorna NULL se a função falhar.
Função: ReleaseDC
Descrição:

A função ReleaseDC libera o contexto de dispositivo (DC) obtido com GetDC para a janela especificada por hwnd. Esta função deve ser chamada para cada chamada bem-sucedida de GetDC para liberar o DC e evitar vazamentos de recursos.
Parâmetros:

hwnd: O identificador da janela cuja DC deve ser liberada.
hdc: O identificador do contexto de dispositivo a ser liberado.
Retorno:

int: Retorna 1 se a função for bem-sucedida; caso contrário, 0.
Conclusão
A função GetDCFromHwnd fornece uma maneira flexível de obter o contexto de dispositivo (DC) a partir do identificador da janela (hwnd), lidando com vários casos padrão, como a janela ativa e a área de trabalho. Esta implementação e documentação no estilo da linguagem C facilitam a reutilização da função em outros scripts para manipulação gráfica e atualização de janelas.