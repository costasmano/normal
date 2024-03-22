C_LONGINT:C283(vYear)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vMonth)  //Command Replaced was o_C_INTEGER

If (Form event code:C388=On Load:K2:1)
	vMonth:=Month of:C24(Current date:C33(*))
	aMonths:=vMonth
	vYear:=Year of:C25(Current date:C33(*))
	CBwholeyear:=0
End if 