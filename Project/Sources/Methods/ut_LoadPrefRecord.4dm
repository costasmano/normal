//%attributes = {"invisible":true,"executedOnServer":true}
//Method: ut_LoadPrefRecord
//Description
//This method will compare previous saved blob containing data from [Preferences] with current record. If there is a difference a dialog will be displayed 
//and remain open for a 
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 01/05/17, 13:08:44
	//----------------------------------------------------
	Mods_2017_01  //Add code to enable saving of [Preferences] record for server
	//Modified by: administrator (1/5/17 15:16:48)
	// Modified by: )-(1/12/17 10:54:38)
	Mods_2017_01
	//  `pass the name of the folder to ut_ReturnServerExportFolder
	// Modified by: Costas Manousakis-(Designer)-(2/2/17 09:53:13)
	Mods_2017_02
	//  `added unload record at the end and set ro at start
	Mods_NewDownloadCode  //Replace [Preferences]Protocol with [Preferences]LastRefID_L
	//replace [Preferences]zoneinfo with [Preferences]DistrictInformation_s
	//and update code to reflect changes needed
	//Modified by: Chuck Miller (12/27/21 13:37:10)
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Removed   
	//BLOB TO VARIABLE($Preferences_blb;v_57_008_l;$Offset_L)
	//and
	//BLOB TO VARIABLE($Preferences_blb;v_57_004_txt;$Offset_L)
	//as well as references to them
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	
End if 
C_TEXT:C284($PathToPrefFolder_txt)
//TRACE
$PathToPrefFolder_txt:=ut_ReturnServerExportFolder("PrefRecords")

READ ONLY:C145(*)
ALL RECORDS:C47([Preferences:57])
ARRAY TEXT:C222($Documents_atxt; 0)
DOCUMENT LIST:C474($PathToPrefFolder_txt; $Documents_atxt)
SORT ARRAY:C229($Documents_atxt; <)  //`put newest on top
If (Size of array:C274($Documents_atxt)>0)
	$PathToPrefFolder_txt:=$PathToPrefFolder_txt+<>PL_DirectorySep_s+$Documents_atxt{1}
	If (Test path name:C476($PathToPrefFolder_txt)=Is a document:K24:1)
		DOCUMENT TO BLOB:C525($PathToPrefFolder_txt; $Preferences_blb)
		
		
		//SET CHANNEL(10;$PathToPrefFolder_txt)
		//SEND RECORD([Preferences])
		//SET CHANNEL(11)
		Compiler_FieldVariables(Table:C252(->[Preferences:57]))
		C_BLOB:C604($Preferences_blb)
		C_LONGINT:C283($Offset_L)
		$Offset_L:=0
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_013_b; $Offset_L)
		//TRACE
		
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_014_txt; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_007_d; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_001_txt; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_009_txt; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_003_txt; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_010_txt; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_011_b; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_005_b; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_016_txt; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_018_d; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_017_txt; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_015_txt; $Offset_L)
		//BLOB TO VARIABLE($Preferences_blb;v_57_008_l;$Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_006_b; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_002_l; $Offset_L)
		BLOB TO VARIABLE:C533($Preferences_blb; v_57_012_txt; $Offset_L)
		//BLOB TO VARIABLE($Preferences_blb;v_57_004_txt;$Offset_L)
		
		vtMessage:=""
		
		If (v_57_013_b#[Preferences:57]AllowTxRx:13)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]AllowTxRx "+String:C10([Preferences:57]AllowTxRx:13)+" to "+String:C10(v_57_013_b)
		End if 
		
		If (v_57_014_txt#[Preferences:57]DataFileKEY_s:14)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]DataFileKEY_s "+[Preferences:57]DataFileKEY_s:14+" to "+v_57_014_txt
		End if 
		If (v_57_007_d#[Preferences:57]dbDate:7)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]dbDate "+String:C10([Preferences:57]dbDate:7)+" to "+String:C10(v_57_007_d)
		End if 
		If (v_57_001_txt#[Preferences:57]Destination:1)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]Destination "+[Preferences:57]Destination:1+" to "+v_57_001_txt
		End if 
		If (v_57_009_txt#[Preferences:57]DestIP:9)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]DestIP "+[Preferences:57]DestIP:9+" to "+v_57_009_txt
		End if 
		If (v_57_003_txt#[Preferences:57]Forward:3)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]Forward "+[Preferences:57]Forward:3+" to "+v_57_003_txt
		End if 
		If (v_57_010_txt#[Preferences:57]ForwardIP:10)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]ForwardIP "+[Preferences:57]ForwardIP:10+" to "+v_57_010_txt
		End if 
		If (v_57_011_b#[Preferences:57]LockUserTx:11)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]LockUserTx "+String:C10([Preferences:57]LockUserTx:11)+" to "+String:C10(v_57_011_b)
		End if 
		If (v_57_005_b#[Preferences:57]ManualCon:5)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]ManualCon "+String:C10([Preferences:57]ManualCon:5)+" to "+String:C10(v_57_005_b)
		End if 
		If (v_57_016_txt#[Preferences:57]Pontis_DatabaseName_txt:16)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]Pontis_DatabaseName_txt "+[Preferences:57]Pontis_DatabaseName_txt:16+" to "+v_57_016_txt
		End if 
		
		If (v_57_018_d#[Preferences:57]Pontis_LastUpdate_d:18)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]Pontis_LastUpdate_d "+String:C10([Preferences:57]Pontis_LastUpdate_d:18)+" to "+String:C10(v_57_018_d)
		End if 
		If (v_57_017_txt#[Preferences:57]Pontis_ODBCName_txt:17)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]Pontis_ODBCName_txt "+[Preferences:57]Pontis_ODBCName_txt:17+" to "+v_57_017_txt
		End if 
		If (v_57_015_txt#[Preferences:57]Pontis_Password_s:15)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]Pontis_Password_s "+[Preferences:57]Pontis_Password_s:15+" to "+v_57_015_txt
		End if 
		//If (v_57_008_l#[Preferences]LastRefID_L)
		//If (vtMessage="")
		//Else 
		//vtMessage:=vtMessage+Char(Carriage return)
		//End if 
		//vtMessage:=vtMessage+"Change [Preferences]LastRefID_L "+String([Preferences]LastRefID_L)+" to "+String(v_57_008_l)
		//End if 
		If (v_57_006_b#[Preferences:57]ShowPrintDialog:6)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]ShowPrintDialog "+String:C10([Preferences:57]ShowPrintDialog:6)+" to "+String:C10(v_57_006_b)
		End if 
		If (v_57_002_l#[Preferences:57]Transfer Type:2)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]Transfer Type "+String:C10([Preferences:57]Transfer Type:2)+" to "+String:C10(v_57_002_l)
		End if 
		
		If (v_57_012_txt#[Preferences:57]TxUserName:12)
			If (vtMessage="")
			Else 
				vtMessage:=vtMessage+Char:C90(Carriage return:K15:38)
			End if 
			vtMessage:=vtMessage+"Change [Preferences]TxUserName "+[Preferences:57]TxUserName:12+" to "+v_57_012_txt
		End if 
		//If (v_57_004_txt#[Preferences]ZoneInfo)
		//If (vtMessage="")
		//Else 
		//vtMessage:=vtMessage+Char(Carriage return)
		//End if 
		//vtMessage:=vtMessage+"Change [Preferences]ZoneInfo "+[Preferences]ZoneInfo+" to "+v_57_004_txt
		//End if 
		If (vtMessage="")
		Else 
			
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
			[Preferences:57]LastRefID_L:8:=v_57_008_l
			[Preferences:57]ShowPrintDialog:6:=v_57_006_b
			[Preferences:57]Transfer Type:2:=v_57_002_l
			[Preferences:57]TxUserName:12:=v_57_012_txt
			//[Preferences]ZoneInfo:=v_57_004_txt
			SAVE RECORD:C53([Preferences:57])
			
			ut_savePrefRecord  //send another out there as this is the one we want so it is the newest one
			UNLOAD RECORD:C212([Preferences:57])
			READ ONLY:C145([Preferences:57])
		End if 
	Else 
		ut_savePrefRecord  //send another out there as this is the one we want so it is the newest one
		UNLOAD RECORD:C212([Preferences:57])
		READ ONLY:C145([Preferences:57])
	End if 
End if 

UNLOAD RECORD:C212([Preferences:57])
READ ONLY:C145([Preferences:57])
REDUCE SELECTION:C351([Preferences:57]; 0)

//End ut_LoadPrefRecord