If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/17/2007 14:33:10)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(6/6/2007 08:35:37)
	Mods_2007_CM10a
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (Is new record:C668([Parameters:107]))
		If (Length:C16([Parameters:107]ParamCode:1)<=20)  //limitation on activity log ID field
			LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "PARAMETERS")
		End if 
	End if 
End if 