QPC( R := 0 ) {    ; By SKAN,  http://goo.gl/nf7O4G,  CD:01/Sep/2014 | MD:01/Sep/2014
	Static P := 0,  F := 0,     Q := DllCall( "QueryPerformanceFrequency", "Int64P",F )
	Return ! DllCall( "QueryPerformanceCounter","Int64P",Q ) + ( R ? (P:=Q)/F : (Q-P)/F )
}
