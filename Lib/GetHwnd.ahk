#Include WindowFromDC.ahk
#Include GetDC.ahk

/*
 * Function: GetHwnd
 * -----------------
 * Obtém o identificador da janela (hwnd) e o contexto de dispositivo (DC) para a janela especificada.
 *
 * Parameters:
 *   wDC - Parâmetro opcional. Se fornecido, usa este DC para obter o identificador da janela. Caso contrário,
 *         obtém o DC da janela ativa.
 *
 * Returns:
 *   Object - Retorna um objeto com duas propriedades:
 *            - hwnd: O identificador da janela.
 *            - hdc: O contexto de dispositivo (DC) da janela.
 *
 * Description:
 *   A função `GetHwnd` verifica se um contexto de dispositivo (DC) foi fornecido. Se não, obtém o DC da
 *   janela ativa. Em ambos os casos, retorna um objeto contendo o identificador da janela (hwnd) e o DC (hdc).
 */
GetHwnd( wDC := 0 ) {
    ; Se wDC não for fornecido, obtém o DC da janela ativa
    if wDC = 0 {
        hwnd := WinExist()        ; Obtém o identificador da janela ativa
        hdc := GetDC(hwnd)        ; Obtém o DC da janela ativa
    } else {
        hdc := wDC
        hwnd := WindowFromDC( hdc ) ; Obtém o identificador da janela a partir do DC fornecido
    }
    return { hwnd: hwnd, hdc: hdc }
}

/* ChatGPT
Explicação Adicional
Função: GetHwnd
Descrição:

A função GetHwnd verifica se um contexto de dispositivo (DC) foi fornecido. Se não for, obtém o DC da janela ativa. Em ambos os casos, retorna um objeto contendo o identificador da janela (hwnd) e o DC (hdc).
Parâmetros:

wDC (opcional): Se fornecido, usa este DC para obter o identificador da janela. Caso contrário, obtém o DC da janela ativa.
Retorno:

Object: Retorna um objeto com duas propriedades:
hwnd: O identificador da janela.
hdc: O contexto de dispositivo (DC) da janela.
Detalhes de Implementação:

if wDC = 0 { ... }: Se wDC não for fornecido, obtém o DC da janela ativa.
hwnd := WinExist(): Obtém o identificador da janela ativa.
hdc := GetDC(hwnd): Obtém o DC da janela ativa.
else { ... }: Se wDC for fornecido, usa este DC para obter o identificador da janela.
hwnd := WindowFromDC(hdc): Obtém o identificador da janela a partir do DC fornecido.
return { hwnd: hwnd, hdc: hdc }: Retorna um objeto contendo o identificador da janela e o DC.
Função: WindowFromDC
Descrição:

A função WindowFromDC obtém o identificador da janela a partir de um contexto de dispositivo (DC).
Parâmetros:

hdc: O identificador do contexto de dispositivo (DC).
Retorno:

hwnd: O identificador da janela associada ao DC.
Conclusão
A função GetHwnd é útil para obter de forma flexível o identificador da janela e o contexto de dispositivo (DC) a partir de várias fontes. Com esta implementação e documentação no estilo da linguagem C, ela pode ser facilmente reutilizada em outros scripts para manipulação gráfica e atualização de janelas.