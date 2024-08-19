#Include C:\Users\morim\OneDrive\DynamicRegionScren\ShinsImageScanClass\ShinsImageScanClass.ahk


#x:: {

	myArray := Array()
	myShins := ShinsImageScanClass( )
	
	myImagem := myShins.SaveImage( "C:\Users\morim\Desktop\SaveImage.bmp", 200, 200, 300, 300 )
	;( "C:\Users\morim\Desktop\Test001.bmp", &myArray ) ;200, 200, , &x, &y )
	MsgBox( myImagem )
	;MsgBox(  myArray.Length )
	;Sleep( 1000 )
	;MouseMove( myArray.[ 26 ].x, myArray[ 26 ].y )
}

Esc::ExitApp()