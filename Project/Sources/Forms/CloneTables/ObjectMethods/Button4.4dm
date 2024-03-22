
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/05/13, 15:29:24
//----------------------------------------------------
//Method: Object Method: CloneTables.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_LONGINT:C283($Loop_L)
C_POINTER:C301($Table_ptr)


For ($Loop_L; 1; Size of array:C274(TableNumber_al))
	$Table_ptr:=Table:C252(TableNumber_al{$Loop_L})
	LocalCount_al{$Loop_L}:=Records in table:C83($Table_ptr->)
End for 
//End Object Method: CloneTables.Button1

