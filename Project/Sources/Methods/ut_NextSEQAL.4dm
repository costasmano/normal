//%attributes = {"invisible":true,"publishedSql":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 04/15/10, 14:43:07
// ----------------------------------------------------
// Method: ut_NextSEQAL
// Description
// This method is used by calling program via sql function call and returns the next sequence number.
//It should not be used in the same server or DB
//
// Parameters
// ----------------------------------------------------
//$1 Is the sequence name
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:37:58)
	//Ugrade to v11
	//Modified by: Charles Miller (5/3/11 10:27:30)
End if 

C_LONGINT:C283($0)
C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 40

C_LONGINT:C283($0; $ReturnNumber_l)
Inc_Sequence($1; ->$ReturnNumber_l)

$0:=$ReturnNumber_l