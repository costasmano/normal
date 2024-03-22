If (False:C215)
	//Script: bRemove  [Dialogs];"ExportImport"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose: Removes the selected item to the export fields array
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

If (asExpImpFld#0)
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