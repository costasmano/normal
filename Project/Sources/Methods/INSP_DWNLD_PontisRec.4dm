//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/14/06, 09:37:47
	// ----------------------------------------------------
	// Method: INSP_DWNLD_PontisRec
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM03
	// Modified by: costasmanousakis-(Designer)-(8/11/08 10:39:32)
	Mods_2008_CM_5404  // ("INSPDWNLD")
	//  `Clean the FileID Red table
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/27/10 15:20:59)
End if 
C_BOOLEAN:C305($0)

C_LONGINT:C283(NumRecs_L)
C_LONGINT:C283(INSP_RemoteBMSID_L; INSP_RemoteCombID_L; INSP_LocalBMSID_L)
INSP_RemoteBMSID_L:=-1
INSP_LocalBMSID_L:=-1
INSP_RemoteCombID_L:=-1
SQL_Select:="SELECT BMSInspID,  ID FROM [Combined Inspections] WHERE [NBISInspID] = :RemoteInspID_L"
ON ERR CALL:C155("SQL_ERROR")
SQL EXECUTE:C820(SQL_Select; INSP_RemoteBMSID_L; INSP_RemoteCombID_L)
While (Not:C34(SQL End selection:C821))
	SQL LOAD RECORD:C822(SQL all records:K49:10)
End while 
SQL CANCEL LOAD:C824
ON ERR CALL:C155("4D_Errors")
If ((INSP_RemoteBMSID_L>0) & (ut_fTestForSQLor4DError))
	C_TEXT:C284($SQL_Select_txt; $BindToVariable_txt)
	$SQL_Select_txt:=ut_SetSelectForAllFields(Table:C252(->[BMS Inspections:44]); ->$BindToVariable_txt)
	$SQL_Select_txt:=$SQL_Select_txt+" FROM [BMS Inspections] WHERE [Inspection ID] = :INSP_RemoteBMSID_L INTO "+$BindToVariable_txt+";"
	clone_ClearFieldVariables(Table:C252(->[BMS Inspections:44]))
	ut_SQLReturnRecord($SQL_Select_txt; "[BMS Inspections]"; String:C10(INSP_RemoteBMSID_L))
	
	
	If (ut_fTestForSQLor4DError)
		
		ut_Message("DownLoading Pontis Insp.."+<>sCR)
		CREATE RECORD:C68([BMS Inspections:44])
		clone_NewSQLUpdateLocalTable(Table:C252(->[BMS Inspections:44]))
		
		ut_Message("Storing Pontis Insp in log..."+<>sCR)
		C_LONGINT:C283(INSP_LocalDBIEID_i; INSP_LocalTMLDRID_i)  //Command Replaced was o_C_INTEGER// these are defined from the INSP_DWNLD_InspRec method 
		Inc_Sequence("Pontis Insp ID"; ->[BMS Inspections:44]Inspection ID:1)  //get new sequence for local Insp record
		INSP_LocalBMSID_L:=[BMS Inspections:44]Inspection ID:1
		//Save local rec
		[BMS Inspections:44]DBrInspEngr:5:=Num:C11(aDblLookUpDest(Table:C252(->[Personnel:42]); String:C10([BMS Inspections:44]DBrInspEngr:5); "Here"; "MHD BMS"))
		[BMS Inspections:44]TeamLeader:6:=Num:C11(aDblLookUpDest(Table:C252(->[Personnel:42]); String:C10([BMS Inspections:44]TeamLeader:6); "Here"; "MHD BMS"))
		SAVE RECORD:C53([BMS Inspections:44])
		X_CleanIDResTable(Table:C252(->[BMS Inspections:44]); String:C10(INSP_RemoteBMSID_L); "REMOTE")
		G_StoreRecResolution(Table:C252(->[BMS Inspections:44]); String:C10(INSP_LocalBMSID_L); String:C10(INSP_RemoteBMSID_L); <>Destination)
		LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; "Pontis Insp ID")  //log new Insp rec
		INSP_InitDwnlFldPtrArr(Table:C252(->[BMS Inspections:44]); ->[BMS Inspections:44]Inspection ID:1; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]DBrInspEngr:5; ->[BMS Inspections:44]TeamLeader:6)
		INSP_LogTableChanges(1; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)  //log new insp grp chgs
		LogLink(->[BMS Inspections:44]DBrInspEngr:5; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42])  //log DBIE lnk
		LogLink(->[BMS Inspections:44]TeamLeader:6; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42])  //log TmLds lnk
	End if 
	
End if 
$0:=ut_fTestForSQLor4DError

