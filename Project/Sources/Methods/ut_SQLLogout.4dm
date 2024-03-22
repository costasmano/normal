//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/07/10, 13:13:03
//----------------------------------------------------
//Method: ut_SQLLogout
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (9/7/10 13:13:04)
End if 
If (SQLConnectionMade_b)
	SQL LOGOUT:C872
	SQLConnectionMade_b:=False:C215
End if 
//End ut_SQLLogout

