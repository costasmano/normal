//Method: Object Method: [PON_ELEM_INSP].SearchNBE.NBESearch_Defect_2
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/07/15, 17:47:06
	// ----------------------------------------------------
	//Created : 
	Mods_2015_07
End if 
//
If (NBESearch_Defect_2=1)
	OBJECT SET VISIBLE:C603(*; "NBESearch_LB2"; True:C214)
Else 
	OBJECT SET VISIBLE:C603(*; "NBESearch_LB2"; False:C215)
	//DELETE LISTBOX ROW(*;"NBESearch_LB2";0)
End if 

//End Object Method: [PON_ELEM_INSP].SearchNBE.NBESearch_Defect_2