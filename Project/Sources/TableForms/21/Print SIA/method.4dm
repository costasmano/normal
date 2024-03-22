If (Form event code:C388=On Load:K2:1)
	C_LONGINT:C283(vPgs; vPgf)  //Command Replaced was o_C_INTEGER
	
	CBSIANormal:=0
	CBSIAInsp:=1
	// Added 1/4/20001
	CBSIAMA:=0
	//End of change
	vPgs:=0
	vPgf:=0
End if 