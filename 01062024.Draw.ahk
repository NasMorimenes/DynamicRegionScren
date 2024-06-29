#Include .\Lib\createLayer.ahk
#Include .\Lib\Gdip_OnOff.ahk
#Include .\Lib\LayerSeup.ahk
#Include .\Lib\GDIP_V2.ahk
#Include .\Lib\GdipManager.ahk
;#Include layers\Class.ahk

;pToken := 0

Gdip := GdipManager()

CoordMode( "Mouse" ) ;CoordMode, Mouse, Client
MyGui := ""
Create_Layered_GUI( &MyGui, 0, 0, A_ScreenWidth, A_ScreenHeight )
Layered_Window_SetUp( &MyGui, 4, 0, 0, A_ScreenWidth, A_ScreenHeight )
MyPen := New_Pen( "FF0000", ,1 )

Key1 := "LButton"
Key2 := "RButton"

KeyWait( Key1, "D" )
if ( Key1 = Key2) {
    Sleep( 150 )
}
loop {


    if ( !KeyWait( Key2, "D T0,1" ) ) {

        MouseGetPos( &xCoordFim, &yCoordFim )

        if ( A_Index = 1 ) {
            xCoordIni := xCoordFim + 1
            yCoordIni := yCoordFim + 1
            dataGui := Buffer( 16, 0 )
        }

        Gdip_GraphicsClear(MyGui.G)
        MouseGetPos( &xCoordFim, &yCoordFim )
        Gdip_DrawLine(MyGui.G, myPen, xCoordIni, yCoordIni, xCoordFim, yCoordFim )
        UpdateLayeredWindow(MyGui.hwnd, MyGui.hdc)
    }
    else {

        Gdip_GraphicsClear(MyGui.G)        
        UpdateLayeredWindow(MyGui.hwnd, MyGui.hdc)
        break
    }
}

Sleep( 15000 )

Gdip_GraphicsClear(MyGui.G)
Gdip_DeletePen( myPen )
UpdateLayeredWindow(MyGui.hwnd, MyGui.hdc)
Layered_Window_ShutDown( MyGui )


OnExit( Exit )

Exit( q,* ) {
    MsgBox( "Saindo " q)
}

#q::SetTimer( InfoGui, 50 )

InfoGui() {  
    
    global MyGui
    if ( IsObject( MyGui) ) {
        ;MyGui.GetClientPos( &x1, &y1, &w1, &h1)
        /*
        Info :=
        (
            "Hwnd - " MyGui.Hwnd "`n"
            "Title - " MyGui.Title "`n"
            "Name - " MyGui.Name "`n"
            "PosX Cliente - " x1 "`n"
            "PosY Cliente - " y1 "`n"
            "Width Cliente - " w1 "`n"
            "Height Cliente - " h1 "`n"
            "Class - " WinGetClass( "ahk_Id " MyGui.Hwnd ) "`n"
            "ProcessName - " WinGetProcessName( "ahk_Id " MyGui.Hwnd ) "`n"
            "ProcessPath - " WinGetProcessPath( "ahk_Id " MyGui.Hwnd ) "`n"
            "TransColor - " WinGetTransColor( "ahk_Id " MyGui.Hwnd ) "`n"
            "TransDegree - " WinGetTransparent( "ahk_Id " MyGui.Hwnd ) "`n" 
        )
        */
    }
    else {
        Info := " No MyGui "
    }
    MouseGetPos( &t, &b )

    ToolTip( WinExist( "TestGui" ), t + 50, b + 20 )
}

#e::SetTimer( InfoScript )

InfoScript() {
    global MyGui
    HWND := MyGui.Hwnd
    Txt :=
    (
        HWND
    )

    ToolTip( Txt )
}

#w::{
    global MyGui
    MyGui.Destroy()
    MyGui := ""
}

Esc::ExitApp()

/*

global MyGui := { W: 600 ,H: 600 }
global GdipOBJ:={ X: 0 ,Y: 0 ,W: MyGui.W ,H: MyGui.H }
global active_Draw := 0


Gui,1:+AlwaysOnTop -DPIScale
Gui,1:Color,222222
Gui,1:Show,% "w" MyGui.W " h" MyGui.H

GdipOBJ := Layered_Window_SetUp( 4
							   , GdipOBJ.X
							   , GdipOBJ.Y
							   , GdipOBJ.W
							   , GdipOBJ.H
							   , 2
							   , "-Caption -DPIScale +Parent1" )
UpdateLayeredWindow( GdipOBJ.hwnd
				   , GdipOBJ.hdc
				   , GdipOBJ.X
				   , GdipOBJ.Y
				   , GdipOBJ.W
				   , GdipOBJ.H )

MyPen := New_Pen( "FF0000", ,5 )



return
GuiClose:
*^ESC::
	Layered_Window_ShutDown(GdipOBJ)
	ExitApp


DrawStuff:
	Gdip_GraphicsClear(GdipOBJ.G)
	MouseGetPos,ex,ey
	Gdip_DrawLine(GdipOBJ.G, myPen, sx, sy, ex, ey)
	UpdateLayeredWindow(GdipOBJ.hwnd, GdipOBJ.hdc)
	if(GETKEYSTATE("Shift")){
		active_Draw:=0
		SetTimer,DrawStuff,off
		tooltip,% "The lenght is " abs(Sqrt(((sx-ex)**2) + ((sy-ey)**2)))
		Gdip_DeletePen(myPen)
	}
	return




#If (active_Draw=0)
*^LButton::
	active_Draw:=1
	MyPen:=New_Pen("FF0000",,2)
	MouseGetPos,sx,sy
	SetTimer,DrawStuff,10
	return
#If