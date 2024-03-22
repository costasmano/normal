//%attributes = {"invisible":true,"publishedSql":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 06/21/10, 09:51:20
// ----------------------------------------------------
// Method: ut_CTRLReturnActKeys
// Description
// <caret/>
//ut_CTRLReturnActKeys($Destination;$User)
// Parameters
// ----------------------------------------------------
//$1 destination
//$2 User name

// Modified by: Charles Miller (6/21/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:45:10)
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Added 3rd parameter which is last [Activity Log]RefID retrieved
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	
End if 
C_TEXT:C284($1; $2)
C_BLOB:C604($0; $Return_blb)
SET BLOB SIZE:C606($Return_blb; 0)
C_LONGINT:C283($3)

$Return_blb:=ut_SQLReturnActLogRecords($1; $2; $3)
$0:=$Return_blb


//End method ut_CTRLReturnActKeys
