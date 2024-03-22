If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/10/10 20:45:49)
	Mods_2010_12
End if 

C_BOOLEAN:C305($dataNotSaved_B)
$dataNotSaved_B:=False:C215
$dataNotSaved_B:=(DCM_NewItemPart_txt#"")
$dataNotSaved_B:=$dataNotSaved_B & (DCM_NewItemDesc_txt#"")
$dataNotSaved_B:=$dataNotSaved_B & (DCM_NewItemQ_r>0)
If ($dataNotSaved_B)
	CONFIRM:C162("Entered Data not Saved to a New Item! Close This window?"; "Close"; "No")
	If (OK=1)
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 