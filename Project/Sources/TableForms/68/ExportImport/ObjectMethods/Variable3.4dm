If (False:C215)
	//Script: asExpImpFld  [Dialogs];"ExportImport"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose: Removes the selected item to the export fields array
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_LONGINT:C283($LDblClick)
//$LDblClick:=GetDoubleClick 
If (Form event code:C388=On Double Clicked:K2:5)
	$LDblClick:=1
Else 
	$LDblClick:=0
End if 

//$LDblClick:=On Double Clicked   `change made on 6/6/00 for version 6.5
If (asExpImpFld#0) & ($LDblClick=1)
	DELETE FROM ARRAY:C228(asExpImpFld; asExpImpFld)
	DELETE FROM ARRAY:C228(apExpImp; asExpImpFld)
	
	Case of 
		: (Size of array:C274(asExpImpFld)=0)
			asExpImpFld:=0
			
		: (asExpImpFld>Size of array:C274(asExpImpFld))
			asExpImpFld:=Size of array:C274(asExpImpFld)
	End case 
End if 
//End of script