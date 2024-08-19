#Include Includes.ahk
/************************************************************************
 * Image(image,variance:=0,&returnX:=0,&returnY:=0,centerResults:=0,scanDir:=0) {
		if (!this.CacheImage(image))
			return 0
		if (this.AutoUpdate)
			this.Update()
		data := DllCall(this._ScanImage,"Ptr",this.dataPtr,"Ptr",this.imageCache[image],"uchar",variance,"uchar",centerResults,"int",this.scanTypes[scanDir],"cdecl int")
		if (data >= 0) {
			this.MapCoords(data,&returnX,&returnY)
			return 1
		}
		return 0
	}
 **********************************************************************
 */
dff := ScamImage( "C:\Users\morim\Desktop\Test001.bmp" )
MouseMove( dff.X, dff.Y )

class ScamImage {

    __New( Image, ObjFind := "FindShins" ) {

        if ( ObjFind == "FindShins" ) {
            this.ObjScan := FindShins()
        }
        this.Image := Image
        code := Mcode( FindShins._scanImage )
        this.pCode := code.Ptr        
        this.AppendFunc()
        this.ObjScan.CacheImage( this.Image )
        this.Data()
    }

    AppendFunc( ) {
		Loop 16 {
            pos := A_Index - 1
            if ( A_Index <= 10 ) {
                Str := FindShins.Func0%A_Index - 1%
            }
            else {

                Str := FindShins.Func%A_Index - 1%
            }
            p := Mcode( str )
            _p := p.Ptr
            pp := (FindShins.bits ? 24 : 16) + ( pos * a_ptrSize )

            NumPut("ptr",_p,FindShins.dataPtr,pp)
        }
		
		
	}

    Data() {

        this.ObjScan.InternalSeting()

        if (!this.ObjScan.CacheImage( this.image ) )
			return 0

        if  (this.ObjScan.AutoUpdate )
			this.ObjScan.Update()

        data := 
        DllCall(
            this.pCode,
            "Ptr", FindShins.dataPtr,
            "Ptr", FindShins.imageCache[ this.image ],
            "uchar", 0, ;variance,
            "uchar", 0, ;centerResults,
            "int", 0, ;this.scanTypes[scanDir],
            "cdecl int"
        )

        MsgBox( "Data " Data )

        if (data >= 0 ) {
			this.ObjSCan.MapCoords( data, &returnX, &returnY)
            this.X := returnX
            this.Y := returnY
			return 1
		}
    }

}





