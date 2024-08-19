AppendFunc( pos, str ) {
    p := this.mcode(str)
    pp := (this.bits ? 24 : 16) + (pos * a_ptrSize)
    NumPut("ptr",p,this.dataPtr,pp)
}