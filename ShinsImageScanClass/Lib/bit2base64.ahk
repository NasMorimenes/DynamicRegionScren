bit2base64(s)
{
  ListLines((lls := A_ListLines)?0:0)
  s := RegExReplace(s,"[^01]+")
  s.=SubStr("100000",1,6-Mod(StrLen(s),6))
  s := RegExReplace(s,".{6}","|$0")
  Chars := "0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  Loop Parse, Chars
    s := StrReplace(s, "|" . ((i := A_Index-1)>>5&1)
    . (i>>4&1) . (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1), A_LoopField)
  ListLines(lls)
  return s
}