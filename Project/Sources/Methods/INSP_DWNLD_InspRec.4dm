//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/14/06, 09:24:25
	// ----------------------------------------------------
	// Method: INSP_DWNLD_InspRec
	// Description
	// Download an inspection record from the destination server db
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM03
	// Modified by: costasmanousakis-(Designer)-(8/11/08 10:47:27)
	Mods_2008_CM_5404  // ("INSPDWNLD")
	//  `Clean the FileID Red table
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/27/10 11:12:02)
	//Fix delete bug and alert how $0 is returned
	//Modified by: Charles Miller (11/4/11 10:34:11)
End if 
C_BOOLEAN:C305($0)

ut_Message("DownLoading Inspection..."+<>sCR)
If (False:C215)
	//$SQL_Select_txt:=ut_SetSelectForAllFields (Table(->[Inspections]);->$BindToVariable_txt)
	//$SQL_Select_txt:=$SQL_Select_txt+" FROM Inspections WHERE InspID = :RemoteInspID_L INTO "+$BindToVariable_txt+";"
	//Clear_FieldVariables (Table(->[Inspections]))
	//ut_SQLReturnRecord ($SQL_Select_txt;"[Inspections]";String(RemoteInspID_L))
End if 
//$ErrCode_L:=INSP_DWNLD_Record ($ConnID;Table(->[Inspections]);1)
If (Not:C34(SQLError_b)) & (v_27_002_l>0)
	
	
	CREATE RECORD:C68([Inspections:27])
	clone_NewSQLUpdateLocalTable(Table:C252(->[Inspections:27]))
	
	ut_Message("Storing Inspection in log..."+<>sCR)
	Inc_Sequence("Inspections"; ->[Inspections:27]InspID:2)  //get new sequence for local Insp record
	C_LONGINT:C283(INSP_LocalInspID_L; INSP_LocalBMSID_L)
	C_LONGINT:C283(INSP_LocalDBIEID_i; INSP_LocalTMLDRID_i)  //Command Replaced was o_C_INTEGER
	INSP_LocalInspID_L:=[Inspections:27]InspID:2
	//Save local rec
	[Inspections:27]DBrInspEngr:3:=Num:C11(aDblLookUpDest(Table:C252(->[Personnel:42]); String:C10([Inspections:27]DBrInspEngr:3); "Here"; "MHD BMS"))
	[Inspections:27]TeamLeader:4:=Num:C11(aDblLookUpDest(Table:C252(->[Personnel:42]); String:C10([Inspections:27]TeamLeader:4); "Here"; "MHD BMS"))
	INSP_LocalDBIEID_i:=[Inspections:27]DBrInspEngr:3
	INSP_LocalTMLDRID_i:=[Inspections:27]TeamLeader:4
	SAVE RECORD:C53([Inspections:27])
	X_CleanIDResTable(Table:C252(->[Inspections:27]); String:C10(RemoteInspID_L); "REMOTE")
	G_StoreRecResolution(Table:C252(->[Inspections:27]); String:C10(INSP_LocalInspID_L); String:C10(RemoteInspID_L); <>Destination)
	LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; "Inspections")  //log new Insp rec
	INSP_InitDwnlFldPtrArr(Table:C252(->[Inspections:27]); ->[Inspections:27]InspID:2; ->[Inspections:27]BIN:1; ->[Inspections:27]DBrInspEngr:3; ->[Inspections:27]TeamLeader:4)
	INSP_LogTableChanges(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)  //log new insp grp chgs
	LogLink(->[Inspections:27]DBrInspEngr:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42])  //log DBIE lnk
	LogLink(->[Inspections:27]TeamLeader:4; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42])  //log TmLds lnk
End if 

$0:=ut_fTestForSQLor4DError

