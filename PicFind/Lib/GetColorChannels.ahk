/** ( Lib/AppGetSetColor.ahk )
 * 
 * @param collor Integer
 * @param channel "A" or "B" or "G" or "R"
 * @returns {Number} 
 */
GetColorChannels(collor, channel := "") {
    static o := 32
    switch channel {
        case "B":
            Blue := (collor >> 0) & 0xFF
            return Blue

        case "G":
            Green := (collor >> 8) & 0xFF
            return Green

        case "R":
            Red := (collor >> 16) & 0xFF
            return Red

        case "A":
            Alpha := (collor >> 24) & 0xFF
            return Alpha

        default:
            return Help()  ; Chama a função de ajuda se um canal inválido for fornecido
    }
}

Help() {
    _Help :=
    (
    "Usage:
    Ass := GetColorChannels(100, " . Chr(34) . "R" . Chr(34) . ")
    MsgBox(Ass)"
    )
    MsgBox(_Help)
}
