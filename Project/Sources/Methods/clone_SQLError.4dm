//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/02/14, 21:42:54
//----------------------------------------------------
//Method: clone_SQLError
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 

ARRAY LONGINT:C221(SQLErrorNumbers_al; 0)
ARRAY TEXT:C222(SQL_InternalCodes_atxt; 0)
ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)
GET LAST ERROR STACK:C1015(SQLErrorNumbers_al; SQL_InternalCodes_atxt; SQL_InternalDescriptions_atxt)

SQLError_b:=True:C214
//End SQL_ERROR

//End clone_SQLError

