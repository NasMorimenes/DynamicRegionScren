MSLLHOOKSTRUCT( lParam ) {

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
    x := Point( &pt, lParam )
    ;dataMouse( &mouseData, lParam )
    ;times( &time, lParam )
    ;ExtraInfo( &dwExtraInfo, lParam )

    Point( &pt, lParam ) {
        
        x := NumGet( lParam, 0, "UInt" )
        y := NumGet( lParam, 4, "UInt" )
        
        NumPut( "UInt", x, pt, 0 )
        NumPut( "UInt", y, pt, 4 )

        return x
    }
    /*
    dataMouse( &mouseData, lParam ) {

        dataMouse1 := NumGet( lParam,  8, "UShort" )
        dataMouse2 := NumGet( lParam, 10, "UShort" )
        dataMouse3 := NumGet( lParam, 12, "UShort" )
        dataMouse4 := NumGet( lParam, 14, "UShort" )
        
        NumPut( "UShort", dataMouse1, mouseData, 0 )
        NumPut( "UShort", dataMouse3, mouseData, 2 )
        NumPut( "UShort", dataMouse3, mouseData, 4 )
        NumPut( "UShort", dataMouse4, mouseData, 6 )
    }

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
            
    */

    return NumGet( lParam, 0, "UInt" ) ;MSLLHOOKSTRUCT
}