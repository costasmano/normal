//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/09/12, 16:06:23
//----------------------------------------------------
//Method: LB_Quickreport
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/9/12 16:06:23)
	
End if 
C_POINTER:C301($Table_ptr)
$Table_ptr:=Table:C252([LB_QueryTable:147]TableNumber_l:3)

QR REPORT:C197($Table_ptr->; Char:C90(1))

//End LB_Quickreport

