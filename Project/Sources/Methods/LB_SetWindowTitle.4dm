//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/09/12, 12:21:48
//----------------------------------------------------
//Method: LB_SetWindowTitle
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/9/12 12:21:49)
	
End if 
C_POINTER:C301($Table_ptr)
$Table_ptr:=Table:C252([LB_QueryTable:147]TableNumber_l:3)

CREATE EMPTY SET:C140($Table_ptr->; "SelectedRecordsSet")

SET WINDOW TITLE:C213([LB_QueryTable:147]WindowTitle_s:5+" Displaying ["+String:C10(Records in selection:C76($Table_ptr->); "###,###,##0")+" out of "+String:C10(Records in table:C83($Table_ptr->); "###,###,##0")+"] records")

//End LB_SetWindowTitle