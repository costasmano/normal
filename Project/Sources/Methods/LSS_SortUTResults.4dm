//%attributes = {"invisible":true}
//Method: LSS_SortUTResults
//Description
// sort the current selection of UTResults records ; sorting by text field did not work in v11
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/15/16, 17:16:39
	// ----------------------------------------------------
	//Created : 
	Mods_2016_12
End if 
//
ARRAY TEXT:C222($Results_atxt; 0)
ARRAY LONGINT:C221($RecordNumbers_al; 0)
ARRAY LONGINT:C221($Rod_al; 0)
SELECTION TO ARRAY:C260([LSS_UtResult:176]; $RecordNumbers_al; [LSS_UtResult:176]LSS_Location_txt:5; $Results_atxt; [LSS_UtResult:176]LSS_RodNo_L:3; $Rod_al)
MULTI SORT ARRAY:C718($Results_atxt; >; $Rod_al; >; $RecordNumbers_al)
CREATE SELECTION FROM ARRAY:C640([LSS_UtResult:176]; $RecordNumbers_al)
ARRAY TEXT:C222($Results_atxt; 0)
ARRAY LONGINT:C221($RecordNumbers_al; 0)
ARRAY LONGINT:C221($Rod_al; 0)

//End LSS_SortUTResults