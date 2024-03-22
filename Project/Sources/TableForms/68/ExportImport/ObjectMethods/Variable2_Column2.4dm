If (False:C215)
	//SC asFldTypes
	
	//This is identical to ...  
	//Script: asFields  [Dialogs];"ExportImport"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose:Appends the selected item to the export fields array
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_LONGINT:C283($LPosition; $LDblClick)
//$LDblClick:=GetDoubleClick
If (Form event code:C388=On Double Clicked:K2:5)
	$LDblClick:=1
Else 
	$LDblClick:=0
End if 

//$LDblClick:=On Double Clicked   `change made on 6/6/00 for version 6.5
If ((asFields#0) & (ckLayout=0) & (ck4DFormat=0))
	If ($LDblClick=1)
		$LPosition:=Size of array:C274(asExpImpFld)+1
		
		INSERT IN ARRAY:C227(asExpImpFld; $LPosition; 1)
		INSERT IN ARRAY:C227(apExpImp; $LPosition; 1)
		asExpImpFld{$LPosition}:=asFields{asFields}
		apExpImp{$LPosition}:=apFlds{asFields}
		
		asExpImpFld:=$LPosition
		
		If (asFields<Size of array:C274(asFields))
			asFields:=asFields+1
		Else 
			asFields:=0  // So the user doesn't add the last field twice.
		End if 
	End if 
End if 
//End of script
