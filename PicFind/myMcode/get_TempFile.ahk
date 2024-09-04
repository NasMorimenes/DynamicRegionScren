get_TempFile( d := "" ) {


	if ( !StrLen( d ) || !FileExist( d ) ) {
		d := A_Temp
	}
	Loop
		tempName := d "\~temp" A_TickCount ".tmp"
	until !FileExist(tempName)
	
	return tempName
}
