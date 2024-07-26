

class Mutex {
    /**
     * Cria um novo Mutex ou abre um já existente. O mutex é destruído assim que todos os handles para ele são
     * fechados.
     * @param name Opcional. O nome pode começar com "Local\" para ser local à sessão, ou "Global\" para estar
     * disponível em todo o sistema.
     * @param initialOwner Opcional. Se este valor for TRUE e o chamador criou o mutex, o thread chamador obtém
     * a posse inicial do objeto mutex.
     * @param securityAttributes Opcional. Um ponteiro para uma estrutura SECURITY_ATTRIBUTES.
     */
    __New(name?, initialOwner := 0, securityAttributes := 0) {

        this.hMutex := this.CreateMutex()

        if !( this.hMutex ) {            
            throw Error("Unable to create or open the mutex", -1 )
        }
    }

    CreateMutex( Name?, initialOwner := 0, securityAttributes := 0 ) {
        mutexName := 0
        ( IsSet( Name ) && mutexName := Name )
        hMutex :=
        DllCall( 
            "CreateMutex",
            "ptr", securityAttributes,
            "int", initialOwner,
            "str", mutexName,
            "ptr"
        )
        return hMutex
    }

    /**
     * Tenta bloquear (ou sinalizar) o mutex dentro do período de timeout.
     * @param timeout O período de timeout em milissegundos (o padrão é esperar infinitamente)
     * @returns {Integer} 0 = bem-sucedido, 0x80 = abandonado, 0x120 = timeout, 0xFFFFFFFF = falha
     */
    Lock( timeOut := 0xFFFFFFFF ) {
       return this.WaitForSingleObject( timeOut )
    }

    WaitForSingleObject( timeOut ) {
        ;https://learn.microsoft.com/pt-br/windows/win32/api/synchapi/nf-synchapi-waitforsingleobject
        result := 
        DllCall(
            "WaitForSingleObject",
            "ptr", this.hMutex,
            "int", timeOut,
            "UInt"
        )
        return result
    }

    ReleaseMutex() {
        boolMutex :=
        DllCall(
            "ReleaseMutex",
            "ptr", this.hMutex,
            "Int"
        )
        return boolMutex
    }

    CloseHandle() {
        boolHandle :=
        DllCall(
            "CloseHandle",
            "ptr", this.hMutex,
            "Int"
        )
        return boolHandle
    }
    __Delete() {
        MsgBox( "Deletando Mutex")
        this.CloseHandle()
    }

}