
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

SET QUERY DESTINATION:C396(Into set:K19:2; "QuerySet")
QUERY:C277($Table_ptr->)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

USE SET:C118("QuerySet")


//End Object Method: Testing.Button

