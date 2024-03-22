If (False:C215)
	//Form Method: [TIN_Inspections];"ReviewComments" 
	// Modified by: Costas Manousakis-(Designer)-(9/9/16 15:06:30)
	Mods_2016_09
	//  `New Form to print Review Comments
End if 

C_TEXT:C284(vRemarks)
C_TEXT:C284(sDate; sTime)  // Command Replaced was o_C_STRING length was 40
Case of 
	: (Form event code:C388=On Load:K2:1)
		sDate:=String:C10(Current date:C33(*))
		sTime:=String:C10(Current time:C178(*))
		C_LONGINT:C283(vPageNo)
	: (Form event code:C388=On Header:K2:17)
		vPageNo:=Printing page:C275
		
End case 