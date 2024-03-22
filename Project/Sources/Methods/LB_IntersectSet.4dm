//%attributes = {"invisible":true}
//Method: LB_IntersectSet
//Description
//  `Create an intersection of two sets  `
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/16/13, 16:10:45
	// ----------------------------------------------------
	//Created : 
	Mods_2013_12
End if 
//

C_POINTER:C301($Table_ptr)
$Table_ptr:=Table:C252([LB_QueryTable:147]TableNumber_l:3)

UT_SET_Control("INTERSECTION"; $Table_ptr)
LB_ClearHeaders

//End LB_IntersectSet