If (False:C215)
	//Script: bUpArrow  [Dialogs];"ExportImport"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose: Moves the selection marker up one record in the fields array
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

If (asFields>1)
	asFields:=asFields-1
Else 
	asFields:=1
End if 
//End of script