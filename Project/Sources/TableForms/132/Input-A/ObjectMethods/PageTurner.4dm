If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/25/10 17:28:01)
	Mods_2010_04
	//Dont call   `SCPOA_PhotoListBox_OM (On Load ) when going to the photos page.
	
End if 

C_LONGINT:C283($selected_L)
$selected_L:=SectionSCPOASelect_atxt
If ($selected_L>0)
	FORM GOTO PAGE:C247(SCPOA_SectionPage_aL{$selected_L})
	
End if 