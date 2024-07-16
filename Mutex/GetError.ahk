#Include Includes.ahk

GetError( lastError ) {

    Error := GetLastError()
    
    if ( lastError == Error ) {
        return true
    }

    return false
}