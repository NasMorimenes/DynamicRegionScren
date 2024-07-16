MSLLHOOKSTRUCT( wParam ) {

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

    pt := Buffer( 8, 0 )
    mouseData := Buffer( 4, 0)
    flag := Buffer( 0,0 )
    time := Buffer( 4, 0 )
    dwExtraInfo := Buffer( 8, 0 )

    MSLLHOOKSTRUCT := Buffer( 8, 0 )

    Point( pt ) {

        x := NumGet( wParam, 0, "UInt" )
        y := NumGet( wParam, 4, "UInt" )
        
        NumPut( "UInt", x, pt, 0 )
        NumPut( "UInt", y, pt, 4 )
    }

    dataMouse( mouseData ) {

        dataMouse1 := NumGet( wParam,  8, "UShort" )
        dataMouse2 := NumGet( wParam, 10, "UShort" )
        dataMouse3 := NumGet( wParam, 12, "UShort" )
        dataMouse4 := NumGet( wParam, 14, "UShort" )
        
        NumPut( "UShort", dataMouse1, mouseData, 0 )
        NumPut( "UShort", dataMouse3, mouseData, 2 )
        NumPut( "UShort", dataMouse3, mouseData, 4 )
        NumPut( "UShort", dataMouse4, mouseData, 6 )
    }

    times( time ) {
        date := NumGet( wParam, 20, "UInt" )
        NumPut( "UInt", date, time, 0 )
    }

    ExtraInfo( dwExtraInfo ) {

        info := StrGet( NumGet( wParam, 24, "UPtr" ) )
        MsgBox( info )
    }

    NumPut( "Ptr", pt.Ptr,
            "Ptr", mouseData.Ptr,
            "Ptr", flag.Ptr,
            "Ptr", dwExtraInfo.ptr,
            MSLLHOOKSTRUCT )

    return MSLLHOOKSTRUCT
}