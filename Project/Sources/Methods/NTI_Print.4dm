//%attributes = {"invisible":true}
//Method: NTI_Print
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/26/16, 12:09:49
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
	
End if 
//
QUERY:C277([NTI_ELEM_BIN_INSP:183]; [NTI_ELEM_BIN_INSP:183]INSPID:1=[Inspections:27]InspID:2)
ORDER BY FORMULA:C300([NTI_ELEM_BIN_INSP:183]; NTI_ElemSort)

If (Records in selection:C76([NTI_ELEM_BIN_INSP:183])>0)
	
	If ((vPrintPontis=1) & (viInspPreviewErr=0))
		//vTotalPages:=0
		vPageNo:=0  //pages start again for NTEs
		NTI_PrintNTEList(->[NTI_ELEM_BIN_INSP:183])
		
		C_LONGINT:C283($pages_L)
		If (viInspPreviewErr=0)
			$pages_L:=NTI_Print_CommentsWP_BIN
		End if 
	End if 
	
	If ((vPrintPontisField=1) & (viInspPreviewErr=0))
		
		vPageNo:=0  //page numbers don't count for field form
		NTI_PrintNTEList(->[NTI_ELEM_BIN_INSP:183]; "PrintField")
	End if 
	
End if 
//End NTI_Print