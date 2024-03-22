C_LONGINT:C283(vMonth)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vYear)  //Command Replaced was o_C_INTEGER

If ((vYear#0) & (vMonth#0))
	[Cons Inspection:64]InspMonth:34:=Date:C102(String:C10(vMonth)+"/01/"+String:C10(vYear))
	PushChange(1; ->[Cons Inspection:64]InspMonth:34)
End if 