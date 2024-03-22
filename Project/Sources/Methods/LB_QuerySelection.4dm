//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/09/12, 12:49:30
//----------------------------------------------------
//Method: LB_QuerySelection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/9/12 12:49:31)
	
End if 
C_POINTER:C301($Table_ptr)
$Table_ptr:=Table:C252([LB_QueryTable:147]TableNumber_l:3)
QUERY SELECTION:C341($Table_ptr->)
If (OK=1)
	LB_SetWindowTitle
	LB_ClearHeaders
End if 

//End LB_QuerySelection