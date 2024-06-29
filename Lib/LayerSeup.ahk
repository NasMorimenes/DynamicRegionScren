#Include Gdip_OnOff.ahk
#Include createLayer.ahk
#Include GDIP_V2.ahk

;Layered_Window_SetUp( &Casa ,4,5,3,4,4)

Layered_Window_SetUp( &Layered ,Smoothing, x, y, w, h ) {

    Layered.hbm := CreateDIBSection( w, h )
    Layered.hdc := CreateCompatibleDC( )
    Layered.obm := SelectObject(Layered.hdc, Layered.hbm)

    Layered.G := Gdip_GraphicsFromHDC(Layered.hdc)

    Gdip_SetSmoothingMode(Layered.G, Smoothing)
}

