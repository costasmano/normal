//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 06/18/10, 15:17:20
// ----------------------------------------------------
// Method: ut_SQLReturnALRecordKeys
// Description
// <caret/>
//ut_SQLReturnALRecordKeys(
// Parameters
// ----------------------------------------------------


// Modified by: Charles Miller (6/18/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:15:10) 
	Mods_NewDownloadCode  //Replace [Preferences]Protocol with [Preferences]LastRefID_L
	//replace [Preferences]zoneinfo with [Preferences]DistrictInformation_s
	//and update code to reflect changes needed
	//Modified by: Chuck Miller (12/27/21 13:37:10)
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Added parameter 3 which is last refid retrieved
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	
End if 
Compiler_FieldVariables
C_TEXT:C284($1; $2)
v_59_001_txt:=$1
v_59_004_txt:=$2
C_LONGINT:C283($3)  // last ref ID retrieved
v_57_008_L:=$3
C_BLOB:C604(Return_blb)

C_TEXT:C284(SQLQuery_txt)

SQLQuery_txt:="SELECT  {fn ut_CTRLReturnActKeys(:v_59_001_txt,:v_59_004_txt,:v_57_008_L) AS BLOB} FROM Preferences INTO :Return_blb"
ON ERR CALL:C155("SQL_ERROR")  //
Begin SQL
	EXECUTE IMMEDIATE :SQLQuery_txt;
End SQL
If (False:C215)
	//SQL EXECUTE($SQLQuery_txt;Return_blb)
	While (Not:C34(SQL End selection:C821))
		SQL LOAD RECORD:C822
	End while 
	SQL CANCEL LOAD:C824
End if 
C_LONGINT:C283($Offset_l)
$Offset_l:=0

ARRAY LONGINT:C221(ActivityKeys_al; 0)

BLOB TO VARIABLE:C533(Return_blb; ActivityKeys_al; $Offset_l)
ON ERR CALL:C155("4D_Errors")
