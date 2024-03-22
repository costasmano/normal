//%attributes = {"invisible":true}
//Method: PON_ListElements
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 16:42:36
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//

QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]INSPID:21=[Inspections:27]InspID:2)
ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_ElemSort)
CREATE SET:C116([PON_ELEM_INSP:179]; "PON_LISTINSPELEMS")
//End PON_ListElements