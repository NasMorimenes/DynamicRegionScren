/**
 * 
 * @param ScanFn Uma das funções Scan
 * @param {Integer} xBits Arquitetura da função
 * @returns {Float | Integer | String} 
 */
Mcode( ScanFn, xBits := 64 ) {

    pp := 0
    op := 0

    Str := ScanFn( xBits )

    bool := CryptStringToBinary( Str )

    if ( !bool ) {
        return
    }

    p := GlobalAlloc() ;DllCall("GlobalAlloc", "uint", 0, "ptr", pp, "ptr")

    ;Fns
    
    GlobalAlloc() {
        p :=
        DllCall(
            "GlobalAlloc",
            "uint", 0,
            "ptr", pp,
            "ptr"
        )

        return p
    }

    CryptStringToBinary( Str ) {
        Size := 0
        LenStr := StrLen( Str )
        ; Primeira chamada para determinar o tamanho do buffer necessário
        DllCall(
            "crypt32\CryptStringToBinary",
            "str", Str,
            "uint", LenStr,
            "uint", 1,          ; CRYPT_STRING_BASE64
            "ptr", 0,           ; Buffer = 0, apenas para obter o tamanho
            "uint*", &Size,     ; Receberá o tamanho necessário do buffer
            "ptr", 0,
            "ptr", 0
        )
    
        ; Aloca o buffer de memória
        pBuffer := DllCall("GlobalAlloc", "uint", 0x40, "uint", Size, "ptr")
    
        ; Segunda chamada para converter a string e preencher o buffer
        DllCall(
            "crypt32\CryptStringToBinary",
            "str", Str,
            "uint", LenStr,
            "uint", 1,          ; CRYPT_STRING_BASE64
            "ptr", pBuffer,     ; Buffer alocado
            "uint*", Size,      ; Tamanho do buffer
            "ptr", 0,
            "ptr", 0
        )
    
        ; Retorna o ponteiro para o buffer alocado
        return pBuffer
    }
    

    VirtualProtect() {
        bool := 
        DllCall(
            "VirtualProtect",
            "ptr", p,
            "ptr", pp,
            "uint", 0x40,
            "uint*", &o
        )

        return bool
    }

    if (this.bits)
        DllCall("VirtualProtect", "ptr", p, "ptr", pp, "uint", 0x40, "uint*", &op)
    if (DllCall("crypt32\CryptStringToBinary", "str", s[this.bits+1], "uint", 0, "uint", 1, "ptr", p, "uint*", &pp, "ptr", 0, "ptr", 0))
        return p
    DllCall("GlobalFree", "ptr", p)
}

/*
Mcode(str) {
		local pp := 0, op := 0
		s := strsplit(str,"|")
		if (s.length != 2)
			return
		if (!DllCall("crypt32\CryptStringToBinary", "str", s[this.bits+1], "uint", 0, "uint", 1, "ptr", 0, "uint*", &pp, "ptr", 0, "ptr", 0
             DllCall("crypt32\CryptStringToBinary", "str", s[this.bits+1], "uint", 0, "uint", 1, "ptr", p, "uint*", &pp, "ptr", 0, "ptr", 0))
			return
		p := DllCall("GlobalAlloc", "uint", 0, "ptr", pp, "ptr")
		if (this.bits)
			DllCall("VirtualProtect", "ptr", p, "ptr", pp, "uint", 0x40, "uint*", &op)
		if (DllCall("crypt32\CryptStringToBinary", "str", s[this.bits+1], "uint", 0, "uint", 1, "ptr", p, "uint*", &pp, "ptr", 0, "ptr", 0))
			return p
		DllCall("GlobalFree", "ptr", p)
	}