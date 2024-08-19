base64tobit(s) {
	static Chars := "0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

	lls := A_ListLines
	ListLines( ( lls ) ? 0 : 0 )
	Loop Parse, Chars {
		if InStr(s, A_LoopField, 1) {
			i := A_Index - 1
			Dss :=  ( i >> 5 & 1 )
				  . ( i >> 4 & 1 )
				  . ( i >> 3 & 1 )
				  . ( i >> 2 & 1 )
				  . ( i >> 1 & 1 )
				  . ( i & 1 )
			s := StrReplace( s, A_LoopField, Dss, 1)
		}
	}
	s := RegExReplace( RegExReplace(s,"[^01]+"),"10*$" )
	ListLines(lls)
	return s
}