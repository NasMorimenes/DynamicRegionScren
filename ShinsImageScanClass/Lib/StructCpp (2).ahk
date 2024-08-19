;Name := "RECT"

;Members :=
;(
;"
;  LONG left;
;  LONG top;
;  LONG right;
;  LONG bottom;
;"
;)

;Values := [ 0, 10, 15, 1 ]

;Ass := StructCpp( Name, Members, Values )

;MsgBox( NumGet( Ass.struct , Ass.Offset[ 2 ], Ass.AhkTypes[ 2 ] ) )

;for i, j in Ass.AhkTypes {
;	MsgBox NumGet( Ass.struct , Ass.Offset[ i ], Ass.AhkTypes[ i ] )
;}
;tipes := AhkTypes.StructCpp

/*
Name := "BITMAPINFOHEADER"
Members :=
	(
	"DWORD biSize;
  LONG  biWidth;
  LONG  biHeight;
  WORD  biPlanes;
  WORD  biBitCount;
  DWORD biCompression;
  DWORD biSizeImage;
  LONG  biXPelsPerMeter;
  LONG  biYPelsPerMeter;
  DWORD biClrUsed;
  DWORD biClrImportant;"
	)

Values := [ 0, 10, 10, 1, 32, 50, 0 ]

Ass := StructCpp( Name, Members, Values, 7)

for i, j in Ass.AhkTypes {
	MsgBox NumGet( Ass.struct , Ass.Offset[ i ], Ass.AhkTypes[ i ] )
}
;tipes := AhkTypes.StructCpp
;;for i
;MsgBox NumGet( Ass.struct
;			 , Off
;			 , AhkTypes[ A_Index ] )

*/

Class StructCpp {

	; Name - String
	;	Structure name
	; Members - string
	;	type1 member1,[ type2 member2, ..., typeN memberN ]
	; Values - Array
	;	[Values1, Values2...ValuesN]
	; DefaultSize
	;	Values Index - Índice que informa o tamanho da estrutura
	;				   Há estrutura que solicitam esse valor
	;				   No caso de 'BITMAPINFOHEADER' esse valor dependerá dos demais parâmetros e neste caso
	;				deve-se informar o índice e seu valor em Values deve ser 0.
    ;  Set xxxxxxxxx - Não Implement
    ;        Define o tamanho da estrutura
    ;  Get xxxxxxxxx - Não Implement
    ;        Retorna o tamanho da estrutura
    ; AhkTypes - Array
	static WDT := Map( "TBYTE", "CHAR"
				     , "TCHAR", "USHORT"
				     , "HALF_PTR", "A_PtrSize"
				     , "UHALF_PTR", "A_PtrSize"
				     , "BOOL", "INT"
				     , "INT32", "INT"
				     , "LONG", "INT"
				     , "LONG32", "INT"
				     , "LONGLONG", "INT64"
				     , "LONG64", "INT64"
				     , "USN", "INT64"
				     , "HFILE", "PTR"
				     , "HRESULT", "PTR"
				     , "INT_PTR", "PTR"
				     , "LONG_PTR", "PTR"
				     , "POINTER_64", "PTR"
				     , "POINTER_SIGNED", "PTR"
				     , "SSIZE_T", "PTR"
				     , "WPARAM", "PTR"
				     , "BOOLEAN", "UCHAR"
				     , "BYTE", "UCHAR"
				     , "COLORREF", "UINT"
				     , "DWORD", "UINT"
				     , "DWORD32", "UINT"
				     , "LCID", "UINT"
				     , "LCTYPE", "UINT"
				     , "LGRPID", "UINT"
				     , "LRESULT", "UINT"
				     , "PBOOL", "UINT"
				     , "PBOOLEAN", "UINT"
				     , "PBYTE", "UINT"
				     , "PCHAR", "UINT"
				     , "PCSTR", "UINT"
				     , "PCTSTR", "UINT"
				     , "PCWSTR", "UINT"
				     , "PDWORD", "UINT"
				     , "PDWORDLONG", "UINT"
				     , "PDWORD_PTR", "UINT"
				     , "PDWORD32", "UINT"
				     , "PDWORD64", "UINT"
				     , "PFLOAT", "UINT"
				     , "PHALF_PTR", "UINT"
				     , "UINT32", "UINT"
				     , "ULONG", "UINT"
				     , "ULONG32", "UINT"
				     , "DWORDLONG", "UINT64"
				     , "DWORD64", "UINT64"
				     , "UINT64", "UINT64"
				     , "ULONGLONG", "UINT64"
				     , "ULONG64", "UINT64"
				     , "DWORD_PTR", "UPTR"
				     , "HACCEL", "UPTR"
				     , "HANDLE", "UPTR"
				     , "HBITMAP", "UPTR"
				     , "HBRUSH", "UPTR"
				     , "HCOLORSPACE", "UPTR"
				     , "HCONV", "UPTR"
				     , "HCONVLIST", "UPTR"
				     , "HCURSOR", "UPTR"
				     , "HDC", "UPTR"
				     , "HDDEDATA", "UPTR"
				     , "HDESK", "UPTR"
				     , "HDROP", "UPTR"
				     , "HDWP", "UPTR"
				     , "HENHMETAFILE", "UPTR"
				     , "HFONT", "UPTR"
				     , "HGDIOBJ", "UPTR"
				     , "HGLOBAL", "UPTR"
				     , "HHOOK", "UPTR"
				     , "HICON", "UPTR"
				     , "HINSTANCE", "UPTR"
				     , "HKEY", "UPTR"
				     , "HKL", "UPTR"
				     , "HLOCAL", "UPTR"
				     , "HMENU", "UPTR"
				     , "HMETAFILE", "UPTR"
				     , "HMODULE", "UPTR"
				     , "HMONITOR", "UPTR"
				     , "HPALETTE", "UPTR"
				     , "HPEN", "UPTR"
				     , "HRGN", "UPTR"
				     , "HRSRC", "UPTR"
				     , "HSZ", "UPTR"
				     , "HWINSTA", "UPTR"
				     , "HWND", "UPTR"
				     , "LPARAM", "UPTR"
				     , "LPBOOL", "UPTR"
				     , "LPBYTE", "UPTR"
				     , "LPCOLORREF", "UPTR"
				     , "LPCSTR", "UPTR"
				     , "LPCTSTR", "UPTR"
				     , "LPCVOID", "UPTR"
				     , "LPCWSTR", "UPTR"
				     , "LPDWORD", "UPTR"
				     , "LPHANDLE", "UPTR"
				     , "LPINT", "UPTR"
				     , "LPLONG", "UPTR"
				     , "LPSTR", "UPTR"
				     , "LPTSTR", "UPTR"
				     , "LPVOID", "UPTR"
				     , "LPWORD", "UPTR"
				     , "LPWSTR", "UPTR"
				     , "PHANDLE", "UPTR"
				     , "PHKEY", "UPTR"
				     , "PINT", "UPTR"
				     , "PINT_PTR", "UPTR"
				     , "PINT32", "UPTR"
				     , "PINT64", "UPTR"
				     , "PLCID", "UPTR"
				     , "PLONG", "UPTR"
				     , "PLONGLONG", "UPTR"
				     , "PLONG_PTR", "UPTR"
				     , "PLONG32", "UPTR"
				     , "PLONG64", "UPTR"
				     , "POINTER_32", "UPTR"
				     , "POINTER_UNSIGNED", "UPTR"
				     , "PSHORT", "UPTR"
				     , "PSIZE_T", "UPTR"
				     , "PSSIZE_T", "UPTR"
				     , "PSTR", "UPTR"
				     , "PTBYTE", "UPTR"
				     , "PTCHAR", "UPTR"
				     , "PTSTR", "UPTR"
				     , "PUCHAR", "UPTR"
				     , "PUHALF_PTR", "UPTR"
				     , "PUINT", "UPTR"
				     , "PUINT_PTR", "UPTR"
				     , "PUINT32", "UPTR"
				     , "PUINT64", "UPTR"
				     , "PULONG", "UPTR"
				     , "PULONGLONG", "UPTR"
				     , "PULONG_PTR", "UPTR"
				     , "PULONG32", "UPTR"
				     , "PULONG64", "UPTR"
				     , "PUSHORT", "UPTR"
				     , "PVOID", "UPTR"
				     , "PWCHAR", "UPTR"
				     , "PWORD", "UPTR"
				     , "PWSTR", "UPTR"
				     , "SC_HANDLE", "UPTR"
				     , "SC_LOCK", "UPTR"
				     , "SERVICE_STATUS_HANDLE", "UPTR"
				     , "SIZE_T", "UPTR"
				     , "UINT_PTR", "UPTR"
				     , "ULONG_PTR", "UPTR"
				     , "ATOM", "USHORT"
				     , "LANGID", "USHORT"
				     , "WCHAR", "USHORT"
				     , "WORD", "USHORT" )

	static ADT := Map( "PTR", A_PtrSize
				     , "UPTR", A_PtrSize
				     , "SHORT", 2
				     , "USHORT", 2
				     , "INT", 4
				     , "UINT", 4
				     , "INT64", 8
				     , "UINT64", 8
				     , "DOUBLE", 8
				     , "FLOAT", 4
				     , "CHAR", 1
				     , "UCHAR", 1 )

	__New( Name, Members, Values, IndexDefaultSize := 0 ) {

		StructuresSyntaxData := this.SSD( Members )
		if ( !IndexDefaultSize ) {
			NewStructureData := this.NSD( StructuresSyntaxData, Values )
		}
		else {
			MsgBox( "cpp")
			NewStructureData := this.NSD( StructuresSyntaxData, Values, IndexDefaultSize )
		}

	}

	DataInsert( SizeAhkTypes ) {
		this.struct := Buffer( SizeAhkTypes, 0 )
		Loop this.Values.Length {

			NumPut( this.AhkTypes[ A_Index ]
				  , this.Values[ A_Index]
				  , this.struct
				  , this.offset[ A_Index ] )
		}
	}

	SizeAhkDataTypes( aTypes ) {

		return StructCpp.ADT[aTypes]
	}

	WindowsDataTypes( wTypes ) {

		return StructCpp.WDT[wTypes]
	}

	SSD( Members ) {

		trat := RegExReplace( Members, ";", A_Space )
		trat := RegExReplace( trat, "\s+", A_Space )
		trat := Trim( trat )

		WindowsDataTypesOfSyntax :=	Array()
		NameOfMembersInSyntax	:=	Array()

		for i, j in StrSplit( trat, A_Space ) {
			A := Mod( i, 2 )
			if ( A = 1 ) {
				WindowsDataTypesOfSyntax.Push( StrSplit( trat, A_Space )[ A_Index ] )
			}
			else {
				NameOfMembersInSyntax.Push( StrSplit( trat, A_Space )[ A_Index ] )
			}
		}

		StructuresSyntaxData := [ WindowsDataTypesOfSyntax, NameOfMembersInSyntax ]
		return StructuresSyntaxData
	}

	NSD( StructuresSyntaxData, Values, Index := unset ) {
		static SizeAhkTypes := 0
		this.AhkTypes := Array()
		this.Values := Array()
		this.offset := Array( 0 )

		for i, j in Values {
			AhkTypes := this.WindowsDataTypes( StructuresSyntaxData[ 1 ][ i ] )
			SizeAhkTypes += this.SizeAhkDataTypes( AhkTypes )
			this.AhkTypes.Push( AhkTypes )
			this.Values.Push( j )
			this.offset.Push( SizeAhkTypes )
		}
		this.offset.Pop()
		this.Size := SizeAhkTypes
		if ( IsSet( Index ) ) {
			this.Values[ Index ] := SizeAhkTypes
		}
		this.DataInsert( SizeAhkTypes )
	}

}