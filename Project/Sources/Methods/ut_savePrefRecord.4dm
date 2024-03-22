//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 01/05/17, 11:57:58
//----------------------------------------------------
//Method: ut_savePrefRecord
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_01  //Add code to enable saving of [Preferences] record for server
	//Modified by: administrator (1/5/17 15:16:48)
	// Modified by: )-(1/12/17 10:54:38)
	Mods_2017_01
	//  `pass the name of the folder to ut_ReturnServerExportFolder
	Mods_NewDownloadCode  //Replace [Preferences]Protocol with [Preferences]LastRefID_L
	//replace [Preferences]zoneinfo with [Preferences]DistrictInformation_s
	//and update code to reflect changes needed
	//VARIABLE To BLOB($Preferences_blb;v_57_008_l;$Offset_L)
	//and
	//VARIABLE To BLOB(($Preferences_blb;v_57_004_txt;$Offset_L)
	//As well as othere refernces to them
	//Modified by: Chuck Miller (12/27/21 13:37:10)
End if 
C_TEXT:C284($PathToPrefFolder_txt)
$PathToPrefFolder_txt:=ut_ReturnServerExportFolder("PrefRecords")
ALL RECORDS:C47([Preferences:57])

$PathToPrefFolder_txt:=$PathToPrefFolder_txt+<>PL_DirectorySep_s+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+"_PrefsRecord"
//SET CHANNEL(10;$PathToPrefFolder_txt)
//SEND RECORD([Preferences])
//SET CHANNEL(11)
Compiler_FieldVariables(Table:C252(->[Preferences:57]))

v_57_013_b:=[Preferences:57]AllowTxRx:13
v_57_014_txt:=[Preferences:57]DataFileKEY_s:14
v_57_007_d:=[Preferences:57]dbDate:7
v_57_001_txt:=[Preferences:57]Destination:1
v_57_009_txt:=[Preferences:57]DestIP:9
v_57_003_txt:=[Preferences:57]Forward:3
v_57_010_txt:=[Preferences:57]ForwardIP:10
v_57_011_b:=[Preferences:57]LockUserTx:11
v_57_005_b:=[Preferences:57]ManualCon:5
v_57_016_txt:=[Preferences:57]Pontis_DatabaseName_txt:16
v_57_018_d:=[Preferences:57]Pontis_LastUpdate_d:18
v_57_017_txt:=[Preferences:57]Pontis_ODBCName_txt:17
v_57_015_txt:=[Preferences:57]Pontis_Password_s:15
//v_57_008_l:=[Preferences]LastRefID_L
v_57_006_b:=[Preferences:57]ShowPrintDialog:6
v_57_002_l:=[Preferences:57]Transfer Type:2
v_57_012_txt:=[Preferences:57]TxUserName:12
//v_57_004_txt:=[Preferences]ZoneInfo
C_BLOB:C604($Preferences_blb)

VARIABLE TO BLOB:C532(v_57_013_b; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_014_txt; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_007_d; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_001_txt; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_009_txt; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_003_txt; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_010_txt; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_011_b; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_005_b; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_016_txt; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_018_d; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_017_txt; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_015_txt; $Preferences_blb; *)
//VARIABLE TO BLOB(v_57_008_l;$Preferences_blb;*)
VARIABLE TO BLOB:C532(v_57_006_b; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_002_l; $Preferences_blb; *)
VARIABLE TO BLOB:C532(v_57_012_txt; $Preferences_blb; *)
//VARIABLE TO BLOB(v_57_004_txt;$Preferences_blb;*)


BLOB TO DOCUMENT:C526($PathToPrefFolder_txt; $Preferences_blb)

//End ut_savePrefRecord