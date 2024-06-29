OptionsGuis( Interface ) {
    if ( Interface = "" ) {
        Interface := "Default"
    }
    static Options :=
        Map( 
            "guiDesktopDraw", "-Caption", ; +E0x80000 +LastFound +AlwaysOnTop -DPIScale" ,
            "Default", ""
        )
    return Options[ Interface ]
}