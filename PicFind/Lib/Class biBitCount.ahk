;biBitCount.Help()
Ass := biBitCount()
MsgBox( Ass.bitCount )
Ass.SetBitCount( 2 )
class biBitCount {
    ; Propriedade
    static bitCount := map( 1, 1, 4, 4, 8, 8, 16, 16, 24, 24, 32, 32 ) ; Profundidade de cor em bits (1, 4, 8, 16, 24, 32)

    ; Construtor
    __New( bitCount := 24 ) {
        this.bitCount := bitCount
    }

    bitCount {
        get {
            return biBitCount.bitCount[ this.Key ]
        }

        set {
            ;for i, j in biBitCount.bitCount
            ;    if ( Value == j )
            ;        this.Index := i
            this.Key := Value
            return this.bitCount

        }
    }

    ; Método para definir a profundidade de cor
    SetBitCount(bitCount) {
        this.bitCount := bitCount
    }

    ; Método para obter o número de cores possíveis
    GetColorCount() {
        return 2 ** this.bitCount
    }

    ; Método para obter o número de bytes por pixel
    GetBytesPerPixel() {
        return this.bitCount >> 3 ; Dividir por 8
    }

    ; Método para verificar se há canal alfa
    HasAlphaChannel() {
        return (this.bitCount == 32)
    }

    ; Método para obter uma descrição da profundidade de cor
    GetDescription() {
        switch this.bitCount {
            case 1:
                return "Monocromático (1 bit, 2 cores)"
            case 4:
                return "16 cores (4 bits)"
            case 8:
                return "256 cores (8 bits)"
            case 16:
                return "High Color (16 bits, 65.536 cores)"
            case 24:
                return "True Color (24 bits, 16,7 milhões de cores)"
            case 32:
                return "True Color com Alfa (32 bits, 16,7 milhões de cores + transparência)"
            default:
                return "Profundidade de cor desconhecida"
        }
    }

    static Help() {
        MsgBox( Help() )
    }

    ; Método para representar a profundidade de cor como string
    ToString() {
        return "biBitCount: " . this.bitCount . " bits - " . this.GetDescription()
    }
}

Help() {
    Help := 
    (
        "Explicação das Propriedades e Métodos
bitCount: Representa a profundidade de cor em bits (ex: 1, 4, 8, 16, 24, 32).
Métodos
SetBitCount(bitCount): Define a profundidade de cor para o valor fornecido.
GetColorCount(): Retorna o número de cores possíveis para a profundidade de cor atual. Este método calcula 
2
bitCount
2 
bitCount
 .
GetBytesPerPixel(): Retorna o número de bytes por pixel, calculando a profundidade de cor em bits dividida por 8 (deslocando 3 bits para a direita).
HasAlphaChannel(): Verifica se a profundidade de cor atual inclui um canal alfa (retorna verdadeiro para 32 bits).
GetDescription(): Retorna uma descrição textual da profundidade de cor, fornecendo detalhes como o número de cores ou se há suporte para canal alfa.
ToString(): Retorna uma representação da classe como string, combinando a profundidade de cor e sua descrição.
Exemplo de Uso
Aqui está um exemplo de como usar essa classe:

ahk
Copiar código
; Cria uma instância de biBitCount com 24 bits por padrão
bitCount := new biBitCount()

MsgBox, % bitCount.ToString()  ; Mostra " Chr(34 ) "biBitCount: 24 bits - True Color (24 bits, 16,7 milhões de cores)" Chr( 34 ) "

bitCount.SetBitCount(32)
MsgBox, % bitCount.ToString()  ; Mostra " Chr(34 ) "biBitCount: 32 bits - True Color com Alfa (32 bits, 16,7 milhões de cores + transparência)" Chr(34 ) "

MsgBox, % " Chr(34 ) "Bytes por pixel: " Chr(34 ) " . bitCount.GetBytesPerPixel()  ; Mostra " Chr(34 ) "Bytes por pixel: 4" Chr(34 ) "
MsgBox, % " Chr(34 ) "Número de cores: " Chr(34 ) " . bitCount.GetColorCount()    ; Mostra " Chr(34 ) "Número de cores: 4294967296" Chr(34 ) "
Essa classe é útil para gerenciar e entender as características de diferentes profundidades de cor em imagens e pode ser integrada em projetos que envolvem manipulação de imagens ou pixels."
    )
    return Help
}