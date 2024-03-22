If (False:C215)
	//Script: bDownArrow  [Dialogs];"ExportImport"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose: Moves the selection marker up down record in the fields array
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

If (asFields<Size of array:C274(asFields))
	asFields:=asFields+1
Else 
	asFields:=Size of array:C274(asFields)
End if 
EZSetField
//End of script