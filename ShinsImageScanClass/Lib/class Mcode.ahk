/** Usage
 * 
 * #Include ScanImage.ahk
 * 
 * Str := ScanImage()\
 * Ass := Mcode( Str )\
 * pAss := Ass.Ptr\
 * ..\
 * ..
 *
 */
class Mcode {
    ; Atributos da classe

    ; Construtor: Inicializa o objeto com uma string Base64
    __New( Str ) {
        this.Str := Str
        this.Del := 0
    }

    ; Getter para o atributo Ptr
    Ptr {
        get {
            static del := 0
            if ( !this.Del ) {
                del := this.CryptStringToBinary( this.Str )
                return del
            }
            else {
                return del
            }
        }
    }

    ; Método para converter uma string codificada em Base64 para um buffer binário
    CryptStringToBinary( Str ) {

        pBuffer := 0
        
        Size := 0
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
        if ( !pBuffer )
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
        
        if ( !this.VirtualProtect( pBuffer, Size ) ) {
            MsgBox( "erro" )
            this.__Delete()
        }

        ; Retorna o ponteiro para o buffer alocado
        return pBuffer
    }

    ; Método para proteger a memória (por exemplo, tornar o buffer executável)
    VirtualProtect( Ptr, size ) {
        ; PAGE_EXECUTE_READWRITE = 0x40
        OldProtect := 0
        dts := 
        DllCall(
            "kernel32\VirtualProtect",
            "ptr", Ptr,          ; Ponteiro para o buffer
            "uint", Size,        ; Tamanho do buffer
            "uint", 0x40,             ; Nova proteção de página (leitura/escrita/executável)
            "uint*", &OldProtect,
            "Int"       ; Armazena a proteção anterior
        )
        return dts
    }

    ; Destrutor: Libera o buffer de memória quando o objeto é destruído
    __Delete() {
        this.Del := 1
        dss := this.Ptr
        if ( dss ) {    
            ;MsgBox( "GlobalFree")        
            DllCall("GlobalFree", "ptr", dss )
        }
    }
}
