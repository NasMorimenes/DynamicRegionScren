

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

        this.hMutex := Mutex.CreateMutex()
        if !( this.ptr := DllCall("CreateMutex", "ptr", securityAttributes, "int", !!initialOwner, "ptr", IsSet(name) ? StrPtr(name) : 0))
            throw Error("Unable to create or open the mutex", -1)
    }

    static CreateMutex( Name, initialOwner := 0, securityAttributes := 0 ) {
        
        hMutex :=
        DllCall( 
            "CreateMutex",
            "ptr", 0,
            "int", 0,
            "str", mutexName,
            "ptr"
        )
        return hMutex
    }

    }
    /**
     * Tenta bloquear (ou sinalizar) o mutex dentro do período de timeout.
     * @param timeout O período de timeout em milissegundos (o padrão é esperar infinitamente)
     * @returns {Integer} 0 = bem-sucedido, 0x80 = abandonado, 0x120 = timeout, 0xFFFFFFFF = falha
     */
    Lock(timeout:=0xFFFFFFFF) => DllCall("WaitForSingleObject", "ptr", this, "int", timeout, "int")
    ; Libera o mutex (reseta para o estado não sinalizado)
    Release() => DllCall("ReleaseMutex", "ptr", this)
    __Delete() => DllCall("CloseHandle", "ptr", this)
}