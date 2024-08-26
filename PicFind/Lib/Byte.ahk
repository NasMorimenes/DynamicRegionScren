#Include Includes.ahk


class Byte {
    
    __New( Name ) {
        Buffer( 1 )
        this.Name := Name
    }

    Call( Value ) {
        return Value
    }
    
    ToBits() {
        
    }
}