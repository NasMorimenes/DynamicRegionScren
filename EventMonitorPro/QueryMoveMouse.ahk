/**
 * Consulta dos valores armazenados
 * QueryMouseMove(0, lastMouseMove, xPos, yPos)
 * MsgBox, X: %xPos% Y: %yPos% Last Move: %lastMouseMove%
**/



QueryMouseMove( setVars := 0, &lastMouseMove := 0, &xPos := 0, &yPos := 0 ) {

    static QMM_xPos := 0
    static QMM_yPos := 0
    static QMM_lastMouseMove := 0
    global DEBUG_OUTPUT

    if ( !setVars ) {
        xPos:= QMM_xPos
        yPos:= QMM_yPos
        lastMouseMove := QMM_lastMouseMove
        return true
    }

    if ( setVars = -1 ) {

        QMM_xPos := xPos
        QMM_yPos := yPos
        QMM_diffMouseMove := lastMouseMove - QMM_lastMouseMove
        QMM_lastMouseMove := lastMouseMove
        info :=
        (
            " X: " xPos
            " Y: " yPos
            " Last mouseMove: " QMM_diffMouseMove
        )

        if( DEBUG_OUTPUT ) {
            ToolTip( info )
        }
        return TRUE
    }
    if( setVars - 2 ) {
        QMM_xPos:=0
        QMM_yPos:=0
        QMM_lastMouseMove:=0
        return TRUE
    }

    return FALSE
}

/*QueryMouseMove(setVars := 0, byRef lastMouseMove := 0, byRef xPos := 0, byRef yPos := 0) {
    static QMM_xPos := 0, QMM_yPos := 0, QMM_lastMouseMove := 0

    if (!setVars) {
        xPos := QMM_xPos
        yPos := QMM_yPos
        lastMouseMove := QMM_lastMouseMove
        return True
    }

    if (setVars == -1) {
        QMM_xPos := xPos
        QMM_yPos := yPos
        QMM_lastMouseMove := lastMouseMove
        return True
    }

    if (setVars == -2) {
        QMM_xPos := 0
        QMM_yPos := 0
        QMM_lastMouseMove := 0
        return True
    }

    return False
}

A função `QueryMouseMove` é projetada para gerenciar e consultar o estado dos movimentos do mouse. Ela pode ser usada para definir, consultar ou limpar variáveis relacionadas à posição do mouse e o tempo do último movimento. Vou explicar em detalhes como essa função pode ser implementada e utilizada.

### Estrutura da Função `QueryMouseMove`

A função `QueryMouseMove` pode ser configurada para operar em três modos:
1. **Consultar**: Retorna as variáveis armazenadas.
2. **Definir**: Atualiza as variáveis armazenadas.
3. **Limpar**: Reseta as variáveis armazenadas para os valores iniciais.

### Implementação da Função

Aqui está um exemplo de como a função `QueryMouseMove` pode ser implementada:

```ahk
QueryMouseMove(setVars := 0, byRef lastMouseMove := 0, byRef xPos := 0, byRef yPos := 0) {
    static QMM_xPos := 0, QMM_yPos := 0, QMM_lastMouseMove := 0

    if (!setVars) {
        xPos := QMM_xPos
        yPos := QMM_yPos
        lastMouseMove := QMM_lastMouseMove
        return True
    }

    if (setVars == -1) {
        QMM_xPos := xPos
        QMM_yPos := yPos
        QMM_lastMouseMove := lastMouseMove
        return True
    }

    if (setVars == -2) {
        QMM_xPos := 0
        QMM_yPos := 0
        QMM_lastMouseMove := 0
        return True
    }

    return False
}
```

### Explicação da Função

1. **Variáveis Estáticas**:
   - `QMM_xPos`, `QMM_yPos`, e `QMM_lastMouseMove` são variáveis estáticas que mantêm a posição do mouse e o tempo do último movimento.

2. **Consulta (`setVars := 0`)**:
   - Quando `setVars` é 0, a função retorna as variáveis armazenadas (`QMM_xPos`, `QMM_yPos`, `QMM_lastMouseMove`) através dos parâmetros passados por referência.

3. **Definição (`setVars := -1`)**:
   - Quando `setVars` é -1, a função atualiza as variáveis armazenadas com os valores fornecidos (`xPos`, `yPos`, `lastMouseMove`).

4. **Limpeza (`setVars := -2`)**:
   - Quando `setVars` é -2, a função reseta as variáveis armazenadas para os valores iniciais (0).

### Uso da Função `QueryMouseMove`

Para usar a função `QueryMouseMove`, podemos integrá-la na função `MouseMove` para gerenciar estados de movimento do mouse de forma mais robusta.

#### Exemplo de Uso na Função `MouseMove`

Aqui está um exemplo de como `QueryMouseMove` pode ser usada dentro da função `MouseMove`:

```ahk
; Mouse Hook Procedure
MouseMove(nCode, wParam, lParam) {
    Critical
    static lastMouseMove := 0

    if (!nCode && wParam == 0x200) {  ; WM_MOUSEMOVE
        xPos := NumGet(lParam, 0, "Int")
        yPos := NumGet(lParam, 4, "Int")
        if (lastMouseMove = 0) {
            diffMouseMove := 0
        } else {
            diffMouseMove := A_TickCount - lastMouseMove
        }
        lastMouseMove := A_TickCount

        ; Usar QueryMouseMove para definir os valores atuais
        QueryMouseMove(-1, lastMouseMove, xPos, yPos)

        ; Ignorar eventos com Last Move igual a 0
        if (diffMouseMove != 0) {
            info := "Mouse Moved: X=" xPos " Y=" yPos " Last Move: " diffMouseMove
            if (DEBUG_OUTPUT) {
                LogDebug(info, LOG_TO_FILE)
            }
        }
    }

    LRESULT := CallNextHookEx(nCode, wParam, lParam)
    return LRESULT
}
```

#### Exemplo de Consulta e Limpeza

Para consultar ou limpar os valores armazenados por `QueryMouseMove`, podemos fazer o seguinte:

```ahk
; Consulta dos valores armazenados
QueryMouseMove(0, lastMouseMove, xPos, yPos)
MsgBox, X: %xPos% Y: %yPos% Last Move: %lastMouseMove%

; Limpeza dos valores armazenados
QueryMouseMove(-2)
```

### Conclusão

A função `QueryMouseMove` permite um gerenciamento flexível e eficiente dos estados de movimento do mouse, possibilitando a definição, consulta e limpeza de variáveis relacionadas. Isso torna o código mais modular e facilita a manutenção e expansão futura.