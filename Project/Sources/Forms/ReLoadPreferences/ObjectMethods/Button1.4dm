
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 01/05/17, 13:39:37
//----------------------------------------------------
//Method: Object Method: ReLoadPreferences.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_01  //Add code to enable saving of [Preferences] record for server
	//Modified by: administrator (1/5/17 15:16:48)
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Removed zone info which became last ref id
	//Changed to [Preferences]DistrictInformation_s
	//Modified by: Chuck Miller (1/11/22 10:57:26)
End if 
ut_LoadRecord(->[Preferences:57])
[Preferences:57]AllowTxRx:13:=v_57_013_b
[Preferences:57]DataFileKEY_s:14:=v_57_014_txt
[Preferences:57]dbDate:7:=v_57_007_d
[Preferences:57]Destination:1:=v_57_001_txt
[Preferences:57]DestIP:9:=v_57_009_txt
[Preferences:57]Forward:3:=v_57_003_txt
[Preferences:57]ForwardIP:10:=v_57_010_txt
[Preferences:57]LockUserTx:11:=v_57_011_b
[Preferences:57]ManualCon:5:=v_57_005_b
[Preferences:57]Pontis_DatabaseName_txt:16:=v_57_016_txt
[Preferences:57]Pontis_LastUpdate_d:18:=v_57_018_d
[Preferences:57]Pontis_ODBCName_txt:17:=v_57_017_txt
[Preferences:57]Pontis_Password_s:15:=v_57_015_txt
//[Preferences]LastRefID_L:=v_57_008_l
[Preferences:57]ShowPrintDialog:6:=v_57_006_b
[Preferences:57]Transfer Type:2:=v_57_002_l
[Preferences:57]TxUserName:12:=v_57_012_txt
[Preferences:57]DistrictInformation_s:4:=v_57_004_txt
SAVE RECORD:C53([Preferences:57])
UNLOAD RECORD:C212([Preferences:57])

//End Object Method: ReLoadPreferences.Button1

