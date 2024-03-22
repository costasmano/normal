If (False:C215)
	//Script: bInsert  [Dialogs];"ExportImport"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose: Inserts the selected item to the export fields array
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_LONGINT:C283($LPosition)

If (asExpImpFld=0)
	$LPosition:=Size of array:C274(asExpImpFld)+1
Else 
	$LPosition:=asExpImpFld
End if 

INSERT IN ARRAY:C227(asExpImpFld; $LPosition)
INSERT IN ARRAY:C227(apExpImp; $LPosition)
asExpImpFld{$LPosition}:=asFields{asFields}
apExpImp{$LPosition}:=apFlds{asFields}

asExpImpFld:=$LPosition

If (asFields<Size of array:C274(asFields))
	asFields:=asFields+1
Else 
	asFields:=0  // So the user doesn't add the last field twice.
End if 
//End of script
