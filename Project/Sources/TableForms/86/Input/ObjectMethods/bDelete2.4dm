If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/17/2007 14:17:36)
	Mods_2007_CM07
End if 

If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (ok=1)
		If (Not:C34(Is new record:C668([Templates:86])))
			LogDeletion(->[Templates:86]TemplateID:1; ->[Templates:86]TemplateID:1; ->[Templates:86]TemplateID:1; 0)
		End if 
		DELETE RECORD:C58([Templates:86])
		CANCEL:C270
	End if 
End if 
