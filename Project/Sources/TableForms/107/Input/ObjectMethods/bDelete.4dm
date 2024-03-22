If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(6/6/2007 08:34:19)
	Mods_2007_CM10a
End if 
If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (ok=1)
		If (Not:C34(Is new record:C668([Parameters:107])))
			If (Length:C16([Parameters:107]ParamCode:1)<=20)  //limitation on activity log ID field
				LogDeletion(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
			End if 
			
		End if 
		DELETE RECORD:C58([Parameters:107])
		CANCEL:C270
	End if 
End if 