#Include Includes.ahk

;Ass := FindShins()
;Ass.InternalSeting()

class FindShins {

    static tBufferPtr := Buffer( 1048576,0 )
    static dataPtr := Buffer(1024,0)

    static WindowScale := 1

    static bits := ( A_PtrSize == 8 )

    static DesktopRegion := { x1 : 0,
                              y1 : 0,
                              x2 : a_screenwidth,
                              y2 : a_screenheight,
                               w : a_screenwidth,
                               h : a_screenheight }

    static imageCache := Map()

    static offsetX := 0,
           offsetY := 0

    static _scanImage := ScanImage(),
           _scanImageArray := ScanImageArray(),
           _scanImageArrayRegion := ScanImageArrayRegion(),
           _scanImageCount := ScanImageCount(),
           _scanImageCountRegion := ScanImageCountRegion(),
           _scanImageRegion := ScanImageRegion(),
           _scanPixel := ScanPixel()
           _scanPixelCount := ScanPixelCount()
           _scanPixelCountRadius := ScanPixelCountRadius(),
           _scanPixelCountRegion := ScanPixelCountRegion(),
           _scanPixelArrayRegion := ScanPixelArrayRegion(),
           _scanPixelPosition := ScanPixelPosition(),
           _scanPixelRegion := ScanPixelRegion()

    static Func00 := Func00(),
           Func01 := Func01(),
           Func02 := Func02(),
           Func03 := Func03(),
           Func04 := Func04(),
           Func05 := Func05(),
           Func06 := Func06(),
           Func07 := Func07(),
           Func08 := Func08(),
           Func09 := Func09(),
           Func10 := Func10(),
           Func11 := Func11(),
           Func12 := Func12(),
           Func13 := Func13(),
           Func14 := Func14(),
           Func15 := Func15()

    static _cacheTargetImageFile := ICacheCode()

    static scanTypes :=
        Map(
            "LRTB",	0,
            "RLTB",	2,
            "LRBT",	1,
            "RLBT",	3,
            "TBRL",	7,
            "TBLR",	6,
            "BTRL",	5,
            "BTLR",	4,
            "0",	0
        )

    static lastError := ""
    static desktop := 0

    __New( title := "", UseClientArea_OrMainMonitor := 1 ) {

		this.AutoUpdate := 1
        this.gdiplusToken := 0
        this.desktop := FindShins.desktop
        this.UseClientArea := UseClientArea_OrMainMonitor

        if ( UseClientArea_OrMainMonitor ) {
			coordmode "mouse","client"
		}
        else {
			coordmode "mouse","window"
		}

        ( title == "" && title := "A")

        if ( !this.hwnd := winexist( title ) ) {
			msgbox "Could not find window: " title "!`n`nScanner will not function!"
			return
		}

    }
    
    ;########################################## 
	;  internal functions used by the class
	;##########################################

    InternalSeting() {

        this.LoadLib( "gdiplus" )

		gsi := Buffer(24,0)
		NumPut("uint",1,gsi,0)
		token := 0
		DllCall("gdiplus\GdiplusStartup", "Ptr*", &token, "Ptr", gsi, "Ptr*", 0)
		this.gdiplusToken := token

        gw := gh := 0
		if (!this.GetRect(&gw,&gh))
			return

        this.width := gw
		this.height := gh
		this.srcDC :=
			DllCall(
				"GetDCEx",
				"Ptr", this.hwnd,
				"Uint", 0,
				"Uint", (this.UseClientArea ? 0 : 1)
			)
		this.dstDC :=
			DllCall( 
				"CreateCompatibleDC",
				"Ptr", 0
			)

		NumPut( "Ptr", FindShins.tBufferPtr.ptr, FindShins.dataPtr, ( FindShins.bits ? 8 : 4 ) )
		this.CreateDIB()
    }
    

	CheckRegion(&x, &y, &w, &h) {
		if (w < 0) {
			w := -w
			x -= w
		}
		if (h < 0) {
			h := -h
			y -= h
		}
	}

	CheckWindow() {
	
		if (this.UseClientArea and !this.GetClientRect(&w,&h))
			return 0
		else if (!this.UseClientArea and !this.GetWindowRect(&w,&h))
			return 0
			
		if (w != this.width or h != this.height) {
			this.width := w
			this.height := h
			DllCall("DeleteObject","Ptr",this.hbm)
			this.CreateDIB()
		}
		return 1
	}
	MapCoords(d,&x,&y) {
		x := (this.offsetX + (d>>16)) * FindShins.WindowScale
		y := (this.offsetY + (d&0xFFFF)) * FindShins.WindowScale
	}
	CreateDIB() {
		bi := Buffer(40,0)
		NumPut("int",this.width,bi,4)
		NumPut("int",-this.height,bi,8)
		NumPut("uint",40,bi,0)
		NumPut("ushort",1,bi,12)
		NumPut("ushort",32,bi,14)
		_scan := 0
		this.hbm := DllCall("CreateDIBSection", "Ptr", this.dstDC, "Ptr", bi.ptr, "uint", 0, "Ptr*", &_scan, "Ptr", 0, "uint", 0, "Ptr")
		MsgBox( _scan )
        this.temp0 := _scan
		NumPut("Ptr",_scan,FindShins.dataPtr,0)
		NumPut("uint",this.width,FindShins.dataPtr,(FindShins.bits ? 16 : 8))
		NumPut("uint",this.height,FindShins.dataPtr,(FindShins.bits ? 20 : 12))
		DllCall("SelectObject", "Ptr", this.dstDC, "Ptr", this.hbm)
	}
	__Delete() {
        if ( this.gdiplusToken ) {
            MsgBox( "Encerando a GDIp!" )
		    DllCall("gdiplus\GdiplusShutdown", "Ptr*", this.gdiplusToken)
        }
        else {
            MsgBox( "GDIp não foi inicializada!" )
        }
	}
	CacheImage(image) {
		if (FindShins.imageCache.has(image))
			return 1
		if (image = "") {
			msgbox "Error, expected resource image path but empty variable was supplied!"
			return 0
		}
		if (!FileExist(image)) {
			msgbox "Error finding resource image: '" image "' does not exist!"
			return 0
		}
		bm := w := h := 0
		DllCall("gdiplus\GdipCreateBitmapFromFile", "Str", image, "Ptr*", &bm)
		DllCall("gdiplus\GdipGetImageWidth", "Ptr", bm, "Uint*", &w)
		DllCall("gdiplus\GdipGetImageHeight", "Ptr", bm, "Uint*", &h)
		r := Buffer(16,0)
		NumPut("uint",w,r,8)
		NumPut("uint",h,r,12)
		bmdata := Buffer(32,0)
		DllCall("Gdiplus\GdipBitmapLockBits", "Ptr", bm, "Ptr", r, "uint", 3, "int", 0x26200A, "Ptr", bmdata)
		scan := NumGet(bmdata, 16, "Ptr")
		p := DllCall("GlobalAlloc", "uint", 0x40, "ptr", 16+((w*h)*4), "ptr")
		NumPut("uint",(w<<16)+h,p,0)
		loop ((w*h)*4)
			NumPut("uchar",NumGet(scan,a_index-1,"uchar"),p,a_index+7)
		loop (w*h)
			if (NumGet(scan,(a_index-1)*4,"uint") < 0xFF000000) {
				NumPut("uint",1,p+4,0)
				break
			}
		DllCall("Gdiplus\GdipBitmapUnlockBits", "Ptr", bm, "Ptr", bmdata)
		DllCall("gdiplus\GdipDisposeImage", "ptr", bm)
		FindShins.ImageCache[image] := p
		return 1
	}

	Update(x:=0,y:=0,w:=0,h:=0,applyOffset:=1) {

		if (this.desktop) {
			DllCall("gdi32\BitBlt", "Ptr", this.dstDC, "int", 0, "int", 0, "int", (!w||w>FindShins.desktopRegion.w?FindShins.desktopRegion.w:w), "int", (!h||h>FindShins.desktopRegion.h?FindShins.desktopRegion.h:h), "Ptr", this.srcDC, "int", FindShins.desktopRegion.x1+x, "int", FindShins.desktopRegion.y1+y, "uint", 0xCC0020) ;40
		} else if (this.CheckWindow()) {
			DllCall("gdi32\BitBlt", "Ptr", this.dstDC, "int", 0, "int", 0, "int", (!w||w>this.width?this.width:w), "int", (!h||h>this.height?this.height:h), "Ptr", this.srcDC, "int", x, "int", y, "uint", 0xCC0020) ;40
		} else { 
			return 0
		}
		if (applyOffset) {
			this.offsetX := x, this.offsetY := y
		} else {
			this.offsetX := this.offsetY := 0
		}
	}

	GetRect(&w, &h) {
		if (this.desktop) {
			w := FindShins.desktopRegion.w
			h := FindShins.desktopRegion.h
			return 1
		}
		if (this.UseClientArea) {
			if (!this.GetClientRect(&w,&h)) {
				msgbox "Problem with Client rectangle dimensions, is window minimized?`n`nScanner will not function!`n`n" this.lastError
				return 0
			}
		} else {
			if (!this.GetWindowRect(&w,&h)) {
				msgbox "Problem with Window rectangle dimensions, is window minimized?`n`nScanner will not function!`n`n" this.lastError
				return 0
			}
		}
		return 1
	}

	GetClientRect(&w, &h) {
		buff := Buffer(32,0)
		if ( !DllCall("GetClientRect", "Ptr", this.hwnd, "Ptr", buff))
			return this.err(-1,"Call to GetClientRect failed for hwnd: " this.hwnd)
		w := NumGet(buff,8,"int")
		h := NumGet(buff,12,"int")
		if (w <= 0 or h <= 0)
			return this.err(-2,"GetClientRect returned invalid dimensions (" w "," h ") for hwnd: " this.hwnd)
		return 1
	}
    
	GetWindowRect(&w, &h) {
		buff := Buffer(32,0)
		if (!DllCall("GetWindowRect", "Ptr", this.hwnd, "Ptr", buff))
			return this.err(-1,"Call to GetWindowRect failed for hwnd: " this.hwnd )
		x := NumGet(buff,0,"int")
		y := NumGet(buff,4,"int")
		w := NumGet(buff,8,"int") - x
		h := NumGet(buff,12,"int") - y
		if (w <= 0 or h <= 0)
			return this.err(-2,"GetWindowRect returned invalid dimensions (" w "," h ") for hwnd: " this.hwnd)
		return 1
	}
	/*
	AppendFunc(pos,str) {

		p := this.mcode(str)
		pp := (FindShins.bits ? 24 : 16) + (pos * a_ptrSize)
		NumPut("ptr",p,FindShins.dataPtr,pp)
	}
	/*
	Mcode(str) {
		local pp := 0, op := 0
		s := strsplit(str,"|")
		if (s.length != 2)
			return
		;if ( FindShins.bits == 0 ) {
		;	;z := 1
		;}
		;else {
		;	z := 2
		;}
		;str := s[ z ]
		;
		;
		if (!DllCall("crypt32\CryptStringToBinary", "str", s[FindShins.bits+1], "uint", 0, "uint", 1, "ptr", 0, "uint*", &pp, "ptr", 0, "ptr", 0))
			return
		p := DllCall("GlobalAlloc", "uint", 0, "ptr", pp, "ptr")
		;FindShins.bits := ( a_ptrsize == 8 ) ;0=32,1=64
		
		;if ( A_PtrSize == 8 )
		;	FindShins.bits := 1
		;else 
		;	FindShins.bits := 0
		
		if (FindShins.bits)
			DllCall("VirtualProtect", "ptr", p, "ptr", pp, "uint", 0x40, "uint*", &op)

		if (DllCall("crypt32\CryptStringToBinary", "str", s[FindShins.bits+1], "uint", 0, "uint", 1, "ptr", p, "uint*", &pp, "ptr", 0, "ptr", 0))
			return p
		DllCall("GlobalFree", "ptr", p)
	}
	*/
	LoadLib(lib*) {
		for k,v in lib
			if (!DllCall("GetModuleHandle", "str", v, "Ptr"))
				DllCall("LoadLibrary", "Str", v) 
	}
	Err(v,r) {
		this.lastError := r
		return v
	}
}