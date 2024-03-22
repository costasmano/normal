//%attributes = {"invisible":true}
// Method: NTI_Print_TIN
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 05/23/16, 16:57:26
	// ----------------------------------------------------
	// First Release
	Mods_2016_NTE
End if 

//
NTI_ListElements_TIN

If (Records in selection:C76([NTI_ELEM_TIN_INSP:185])>0)
End if 

If (vPrintPontis=1)
	vPageNo:=0
	
	NTI_PrintNTEList(->[NTI_ELEM_TIN_INSP:185]; "All_Item_Tunnel_Inspection")
End if 

If (vPrintPontisField=1)
	NTI_PrintNTEList(->[NTI_ELEM_TIN_INSP:185]; "PrintField")
End if 

//End NTI_Print