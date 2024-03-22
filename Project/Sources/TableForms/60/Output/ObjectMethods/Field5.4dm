If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(4/19/11 10:40:08)
	Mods_2011_04
	//Added check if [FileIDRes Table]File Number : v11 Fix
End if 

If (Form event code:C388=On Display Detail:K2:22)
	If ([FileIDRes Table:60]File Number:1>0)
		vTablNam:=Table name:C256([FileIDRes Table:60]File Number:1)
	End if 
End if 