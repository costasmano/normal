//%attributes = {"invisible":true,"publishedSql":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/11/10, 14:13:55
//----------------------------------------------------
//Method: ut_CTRLReturnINSPActKeys
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 14:13:57)
End if 
C_TEXT:C284($1; $2)
C_LONGINT:C283($Count_l; $0)


$Count_l:=ut_SQLReturnINSActRecords($1; $2)
$0:=$Count_l
//End ut_CTRLReturnINSPActKeys

