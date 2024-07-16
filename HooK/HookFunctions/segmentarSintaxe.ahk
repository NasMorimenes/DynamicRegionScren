/*
Cria um objeto a partir da sintaxe de uma estrutura em C/C++.

Sintaxe:
    syntax := "
    (
    typedef struct tagPOINT {
        LONG x;
        LONG y;
    } POINT, *PPOINT, *NPPOINT, *LPPOINT;
    )"
    estrutura := SegmentarEstrutura(syntax)

Parâmetros:
    - syntax: String com a definição da estrutura em C/C++.

Retorna:
    Objeto com as propriedades:
        - name: Nome da estrutura.
        - members: Lista de membros da estrutura.
        - typedefs: Lista de typedefs.

Exemplo:
    syntax := "
    (
    typedef struct tagRECT {
        LONG left;
        LONG top;
        LONG right;
        LONG bottom;
    } RECT, *PRECT, *NPRECT, *LPRECT;
    )"
    estrutura := SegmentarEstrutura(syntax)
    if IsSet(estrutura) && estrutura {
        MsgBox("Nome da Estrutura: " estrutura.name "`nMembros: " estrutura.members[1].name " - " estrutura.members[1].type ", " estrutura.members[2].name " - " estrutura.members[2].type "`nTypedefs: " estrutura.typedefs[1] ", " estrutura.typedefs[2] ", " estrutura.typedefs[3] ", " estrutura.typedefs[4])
    } else {
        MsgBox("Falha ao segmentar a estrutura")
    }

Créditos:
    Desenvolvido por Morimenes and ChatGPT 15JUN2024
*/
SegmentarEstrutura( syntax ) {
    estrutura := {}
    regex := "typedef\s+struct\s+(\w+)\s*\{\s*([^}]+)\s*\}\s*(.+);"
    if RegExMatch(syntax, regex, &match) {
        estrutura.name := match.1
        estrutura.members := []        
        ; Segmentar membros
        for each, member in StrSplit(match.2, "`n", "`r") {
            regex := "^\s*(\w+)\s+(\w+);"            
            if RegExMatch(member, regex, &memberMatch) { 
                estrutura.members.Push({type: memberMatch.1, name: memberMatch.2})
            }
        }
        ; Segmentar typedefs
        estrutura.typedefs := StrSplit(match.3, ", ", "`r")

        return estrutura
    }
    Text := "Estrutura não correspondeu: " syntax
    return Text
}


; Exemplo de uso
syntax := "
(
typedef struct tagPOINT {
  LONG x;
  LONG y;
} POINT, *PPOINT, *NPPOINT, *LPPOINT;
)"
estrutura := SegmentarEstrutura(syntax)

A1 := estrutura.name                ; "tagPOINT"
A2 := estrutura.members[1].name     ; "x"
A3 := estrutura.members[1].type     ; "LONG"
A4 := estrutura.members[2].name     ; "y"
A5 := estrutura.members[2].type     ; "LONG"
A6 := estrutura.typedefs[1]         ; "POINT"
A7 := estrutura.typedefs[2]         ; "*PPOINT"
A8 := estrutura.typedefs[3]         ; "*PPOINT"
A9 := estrutura.typedefs[4]         ; "*PPOINT"

