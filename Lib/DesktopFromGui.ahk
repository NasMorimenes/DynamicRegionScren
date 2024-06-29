DesktopFromGui( myGui, Opt_E, Title, Opt_S ) {
    
    myGui :=
    Gui(
        Opt_E ,
        Title
    )
    myGui.Show ( Opt_S )

    return myGui.Hwnd
}