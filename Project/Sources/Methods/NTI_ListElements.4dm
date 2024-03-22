//%attributes = {"invisible":true}
//Method: NTI_ListElements
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/21/16, 17:09:04
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//

QUERY:C277([NTI_ELEM_BIN_INSP:183]; [NTI_ELEM_BIN_INSP:183]INSPID:1=[Inspections:27]InspID:2)
ORDER BY FORMULA:C300([NTI_ELEM_BIN_INSP:183]; NTI_ElemSort)
CREATE SET:C116([NTI_ELEM_BIN_INSP:183]; "PON_LISTINSPELEMS")

//End NTI_ListElements