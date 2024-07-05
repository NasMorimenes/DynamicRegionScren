MSLLHOOKSTRUCT( lParam ) {

    ;mouseData := NumGet( lParam, 8, "UInt")

    
    ;# Extrair HighWord (palavra de ordem superior)
    ;high_word :=  NumGet( lParam, 8, "UShort" )
    ;(mouseData >> 16) & 0xFFFF

    ;if ( high_word > 32767 )  ; Delta negativo
    ;    high_word :=  high_word - 65536

    ;# Extrair LowWord (palavra de ordem inferior)
    ;low_word := mouseData & 0xFFFF

    
   
    ;return  high_word ;"`n" low_word


    sintaxe := 
    (
        "typedef struct tagMSLLHOOKSTRUCT {
            POINT     pt;
            DWORD     mouseData;
            DWORD     flags;
            DWORD     time;
            ULONG_PTR dwExtraInfo;
        } MSLLHOOKSTRUCT, *LPMSLLHOOKSTRUCT, *PMSLLHOOKSTRUCT;"
    )

    static pt := Buffer( 8, 0 )
    static mouseData := Buffer( 4, 0)
    static flag := Buffer( 4 ,0 )
    static time := Buffer( 4, 0 )
    static dwExtraInfo := Buffer( 8, 0 )

    static MSLLHOOKSTRUCT := Buffer( 40, 0 )
    
    ;Point( &pt, lParam )
    dataMouse( &mouseData, lParam )
    ;times( &time, lParam )
    ;ExtraInfo( &dwExtraInfo, lParam )

    ;Point( &pt, lParam ) {
        
    ;    x := NumGet( lParam, 0, "UInt" )
    ;    y := NumGet( lParam, 4, "UInt" )
        
    ;    NumPut( "UInt", x, pt, 0 )
    ;    NumPut( "UInt", y, pt, 4 )

    ;    return x
    ;}

    dataMouse( &mouseData, lParam ) {
        
        dataMouse1 := NumGet( lParam,  8, "UShort" )
        dataMouse2 := NumGet( lParam, 10, "UShort" )
        ;dataMouse3 := NumGet( lParam, 12, "UShort" )
        ;dataMouse4 := NumGet( lParam, 14, "UShort" )
        
        NumPut( "UShort", dataMouse1, mouseData, 0 )
        NumPut( "UShort", dataMouse2, mouseData, 2 )
        ;NumPut( "UShort", dataMouse3, mouseData, 4 )
        ;NumPut( "UShort", dataMouse4, mouseData, 6 )
    }
/*
    times( &time, lParam ) {
        date := NumGet( lParam, 20, "UInt" )
        NumPut( "UInt", date, time, 0 )
    }

    ExtraInfo( &dwExtraInfo, lParam ) {
        info := StrGet( NumGet( lParam, 24, "UPtr" ) )
        StrPut( info, dwExtraInfo )
    }

    NumPut( "Ptr", pt.Ptr, MSLLHOOKSTRUCT, 0 )
    NumPut( "Ptr", mouseData.Ptr, MSLLHOOKSTRUCT, 8 )
    NumPut( "Ptr", flag.Ptr, MSLLHOOKSTRUCT, 16 )
    NumPut( "Ptr", time.Ptr, MSLLHOOKSTRUCT, 24 )
    NumPut( "Ptr", dwExtraInfo.Ptr, MSLLHOOKSTRUCT, 32 )

    Obj := { 
        X : NumGet( lParam, 0, "UInt" ),
        Y : NumGet( lParam, 4, "UInt" )
    }
*/
    return mouseData ;NumGet( lParam, 0, "UInt" ) ;MSLLHOOKSTRUCT
}