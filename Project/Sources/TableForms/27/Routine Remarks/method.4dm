//LO: [Inspections];"Routine Remarks"
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
C_TEXT:C284(vRemarks)
C_LONGINT:C283($i; $n)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($str)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(sDate; sTime)  // Command Replaced was o_C_STRING length was 40
Case of 
	: (Form event code:C388=On Load:K2:1)
		sDate:=String:C10(Current date:C33(*))
		sTime:=String:C10(Current time:C178(*))
		C_LONGINT:C283(vPageNo)  //Command Replaced was o_C_INTEGER
	: (Form event code:C388=On Header:K2:17)
		vPageNo:=Printing page:C275
End case 