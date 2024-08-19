Hex1 := "8d41d03c0976298d419f3c05761a8d51bf8d41c9b9ffffffff80fa060fbec00f43c1c30f1f44000083e9570fbec1c3900fbec0c3"
Hex2 := "56534883ec280fbec989d6e800000000400fbece89c3e800000000c1e30409d84883c4285b5ec3"
codes := "cf3cf3cf3cf3cf3cf3cf3cf3cf3cf3cf3cf3cf3cf0df3cb40f3d37ce4e13b36ef2ef4cd4503b34ef3d35ce4d33cb44f3b03cf3cf3cf3cf3cf3cf3c"
Str := StrSplit( codes )

loop Str.Length
	MsgBox( hex_to_dec( Str[ A_Index ] ) )


hex_to_dec( c ) {

	static a := 10, b := 11, c := 12, d := 13, e := 14, f := 15
    if ( c >= '0' && c <= '9' )
		return c - 0
    if ( c >= 'a' && c <= 'f' )
		return c - 'a' + 10
    if (c >= 'A' && c <= 'F')
		return c - 'A' + 10

    return -1
}


/*
code1 := MCode( Hex1 )
code2 := MCode( Hex2 )
loop Str.Length {
	Ass := DllCall( code1, "int", Ord( StrPtr( codes) ) ) 
	if ( Mod( 2, A_Index ) ) {
		dss := DllCall( code1, "Str*", StrPtr( codes)  )
	}

}
MCode( hex ) {
	len := StrLen( hex) // 2
	code := Buffer( len, 0 )
	DllCall(
		"crypt32\CryptStringToBinary",
		"Str", hex,
		"uint", 0,
		"uint", 4,
		"Ptr", code,
		"uint*", &len,
		"Ptr", 0,
		"Ptr", 0
	)
		DllCall(
		"VirtualProtect",
		"Ptr", code,
		"Ptr", len,
		"uint", 0x40,"Ptr*", 0
	)
	return code
}