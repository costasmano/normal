//%attributes = {"invisible":true}
// Method: 4D_Errors
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): Charles Miller
	// Date and time: 06/10/10, 14:25:48
	// Modified by: Charles Miller (6/10/10)
	// ----------------------------------------------------
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:14:05) 
End if 
//TRACE

ARRAY LONGINT:C221(SQLErrorNumbers_al; 0)
ARRAY TEXT:C222(SQL_InternalCodes_atxt; 0)
ARRAY TEXT:C222(SQL_InternalDescriptions_atxt; 0)
GET LAST ERROR STACK:C1015(SQLErrorNumbers_al; SQL_InternalCodes_atxt; SQL_InternalDescriptions_atxt)
4DError_b:=True:C214