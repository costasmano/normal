If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(11/8/2006 09:27:31)
	Mods_2006_CM07
End if 

C_DATE:C307(vToday)
C_TEXT:C284(vAdvanceDays_s)  // Command Replaced was o_C_STRING length was 2

Case of 
	: (Form event code:C388=On Load:K2:1)
		//initialize to default setting
		C_LONGINT:C283($Advance_date)  //Command Replaced was o_C_INTEGER
		$Advance_date:=0
		READ ONLY:C145([Parameters:107])
		QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="INSP_LETTERDATE")
		If (Records in selection:C76([Parameters:107])=1)
			$Advance_date:=Num:C11([Parameters:107]Value:3)
		End if 
		If ($Advance_date=0)
			$Advance_date:=14
		End if 
		READ WRITE:C146([Parameters:107])
		vAdvanceDays_s:=String:C10($Advance_date)
		vToday:=Current date:C33(*)+$Advance_date
End case 
