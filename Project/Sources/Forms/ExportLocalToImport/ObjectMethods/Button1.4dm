
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 05/23/13, 12:44:51
//----------------------------------------------------
//Method: Object Method: Testing.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_POINTER:C301($Table_ptr)
$Table_ptr:=Table:C252(TableNumber_L)

ALL RECORDS:C47($Table_ptr->)

CREATE SET:C116($Table_ptr->; "QuerySet")

USE SET:C118("QuerySet")


//End Object Method: Testing.Button

