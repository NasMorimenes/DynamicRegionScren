#Include GetColloChannels.ahk
/*
Cor := 0

Colors := [ 15, 15, 146, 255]
Canais := [ "B", "G", "R", "A"]

loop Colors.Length {
    SetColorChannels( &Cor, Colors[ A_Index ], Canais[ A_Index ] )
}

loop Colors.Length {
    dss := GetColloChannels( Cor, Canais[ A_Index ] )
    ;MsgBox( dss )
}


SetColorChannels( &Cor, 50, "G" )

loop Colors.Length {
    dss := GetColloChannels( Cor, Canais[ A_Index ] )
    MsgBox( dss )
}
*/
SetColorChannels( &collor, Value, channel ) {
    ; Máscara para limpar o canal antes de definir o novo valor
    static o := 32
    mask := 0xFF
    
    switch channel {
        case "B":
            collor := (collor & ~mask) | (Value << 0)
        case "G":
            collor := (collor & ~(mask << 8)) | (Value << 8)
        case "R":
            collor := (collor & ~(mask << 16)) | (Value << 16)
        case "A":
            collor := (collor & ~(mask << 24)) | (Value << 24)
        default:
            Help()
            return -1
    }
    return collor
}


SetColloChannels( &collor, Value, channel ) {

    ; aBuff | ( Ass << (16  // A_Index) )

    switch channel {
        case "B":
            collor := collor | ( Value << 0 )
            return 0
        case "G":
            collor := collor | ( Value << 8 )
            return 0

        case "R":
            collor := collor | ( Value << 16 )
            return 0

        case "A":
            collor := collor | ( Value << 24 )
            return 0
        default:
            Help()           
    }

    Help() {
        _Help :=
        (
            "Ass := GetColloChannels( 100, " Chr( 34 ) "R" Chr( 34 ) ")
            MsgBox( Ass )"
        )
        MsgBox( _Help )
    }
}