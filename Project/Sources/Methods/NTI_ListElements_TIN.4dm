//%attributes = {"invisible":true}
// Method: NTI_ListElements_TIN
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 05/20/16, 17:42:54
	// ----------------------------------------------------
	// First Release
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(1/25/18 14:11:02)
	Mods_2018_01
	//  `workaround to load [NTI_TunnelInfo] if not loaded
End if 
//
QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
//
ORDER BY FORMULA:C300([NTI_ELEM_TIN_INSP:185]; NTI_ElemSort_TIN)
CREATE SET:C116([NTI_ELEM_TIN_INSP:185]; "PON_LISTINSPELEMS")
If ([NTI_TunnelInfo:181]NTI_i1_s:6#[TIN_Inspections:184]NTI_i1_S:1)
	QUERY:C277([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i1_s:6=[TIN_Inspections:184]NTI_i1_S:1)
	
End if 
//
//End NTI_ListElements