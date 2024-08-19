x64 :=
    (
        "V1ZTiwJEi1kQi3QkQInHwe8QQTn7D4bVAAAAi1kUD7fAOdgPg8cAAABMi1EIQSn7KcNFD7bARQ++yUnHAgAAAABFiVoIQYlaDEWJQhB"
        "FiUoUhfZ0M4P+AXRGg/4CdFGD/gN0NIP+BHRng/4FdHKD/gZ0TYP+Bw+FfQAAAEiLQXjrCmYPH0QAAEiLQVhbXl9I/+BmDx9EAABIi0"
        "Fw6+5mkEiLQWhbXl9I/+BmDx9EAABIi0FgW15fSP/gZg8fRAAASIuBgAAAAOvDDx+AAAAAAEiLgZAAAADrsw8fgAAAAABIi4GIAAAA6"
        "6MPH4AAAAAAuP7///9bXl/DuP/////r9Q=="
    )
Ass := Mcode( 64 )
Ass.Ptr := 20
Mcode.Ptr[ 1 ] := 20
MsgBox( Ass.Ptr )
Ass.Ptr 
;MsgBox( Mcode.Ptr[ 1 ] := 20 )
class Mcode {
    ; Atributos da classe
    static Ptr := Array()
    ;Size := this.Ptr

    ; Construtor: Inicializa o objeto com uma string Base64
    __New( Str ) {
        this.Index := 0
        this.Soma(Str)
    }

    ; Getter para o atributo Ptr
    ;Ptr {
    ;    get {
    ;        return Mcode.Ptr[ this.Index ]
    ;    }
    ;}

    __Set( Key, Params, Value ) {
        Mcode.Ptr.Push( this.Soma( Value ) )
        this.Index := Mcode.Ptr.Length
    }

    soma( x ) {
        static ds := 10
        return x + ds
    }

}
/*

    ; Método para converter uma string codificada em Base64 para um buffer binário
    CryptStringToBinary( Str ) {

        LenStr := StrLen(Str)
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
    
        ; Armazena o tamanho do buffer no objeto
        this.Size := Size

        ; Retorna o ponteiro para o buffer alocado
        return pBuffer
    }

    ; Método para proteger a memória (por exemplo, tornar o buffer executável)
    VirtualProtect() {
        ; PAGE_EXECUTE_READWRITE = 0x40
        OldProtect := 0
        DllCall(
            "kernel32\VirtualProtect",
            "ptr", this.Ptr,          ; Ponteiro para o buffer
            "uint", this.Size,        ; Tamanho do buffer
            "uint", 0x40,             ; Nova proteção de página (leitura/escrita/executável)
            "uint*", OldProtect       ; Armazena a proteção anterior
        )
        return OldProtect
    }

    ; Destrutor: Libera o buffer de memória quando o objeto é destruído
    __Delete() {
        if (this.Ptr) {
            DllCall("GlobalFree", "ptr", this.Ptr)
        }
    }
}