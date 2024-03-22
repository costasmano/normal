If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(8/31/2006 10:31:06)
	Mods_2006_CM06
End if 

//change Date of Approval to the day when user clicks "ADDEN ASSIGNM LETTER" button
// and Save the change
If ([Addendum_Maintenance:102]DateCreated:6=Current date:C33(*))
	
Else 
	C_TEXT:C284($msg)
	$msg:="Change current acceptance date "+String:C10([Addendum_Maintenance:102]DateCreated:6)
	$msg:=$msg+" to today's date ("+String:C10(Current date:C33(*))+") ?"
	CONFIRM:C162($msg; "Change"; "NO")
	If (OK=1)
		[Addendum_Maintenance:102]DateCreated:6:=Current date:C33(*)
		SAVE RECORD:C53([Addendum_Maintenance:102])
	End if 
	$msg:=""
End if 

CM_PrintAddenAssignm_Letter