    class Mutex {

        __New( Name? ) {
            this.Name := 0
            ( IsSet( Name ) && this.Name := StrPtr( Name ) )
            this.mutex := DllCall("CreateMutex", "Ptr", 0, "Int", 0, "Ptr", this.Name, "Ptr" )
        }

        Lock() {
            return DllCall("WaitForSingleObject", "Ptr", this.mutex, "UInt", 0xFFFFFFFF) == 0
        }

        Unlock() {
            return DllCall("ReleaseMutex", "Ptr", this.mutex)
        }

        __Delete() {
            DllCall("CloseHandle", "Ptr", this.mutex)
        }
    }
