//%attributes = {"invisible":true}
// Method: INSP_DownLoadInsp
// Description
// Download a complete remote inspection
// 
// Parameters
// $0 : ErrorCode (L)
// $1 : Connection ID (L)
// $2 : Remote Inspection ID (L)
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/13/06, 16:16:24
	// ----------------------------------------------------
	// ----------------------------------------------------
	Mods_2007_CM03
	// Modified by: costasmanousakis-(Designer)-(8/11/08 11:04:25)
	Mods_2008_CM_5404  // ("INSPDWNLD")
	//  `Clean the FileID Red table
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 16:29:20)
	// Modified by: Costas Manousakis-(Designer)-(10/22/15 17:00:37)
	Mods_2015_10_bug
	//  `Added code to download [PON_ELEM_INSP] and [TunnelInspection] records
	//  `and code to download records from [ElmtRatingLoads]
End if 
C_BOOLEAN:C305($0)

C_LONGINT:C283($1; RemoteInspID_L)

RemoteInspID_L:=$1
C_TEXT:C284($SQL_Select_txt; $BindToVariable_txt)
C_LONGINT:C283($PrevTransferOpt_L; INSP_OPError_L)
C_LONGINT:C283(INSP_LocalInspID_L; INSP_LocalBMSID_L; INSP_RemoteCombID_L)
C_LONGINT:C283(INSP_LocalDBIEID_i; INSP_LocalTMLDRID_i)  //Command Replaced was o_C_INTEGER
//find remote Insp ID
INSP_OPError_L:=0
$SQL_Select_txt:=ut_SetSelectForAllFields(Table:C252(->[Inspections:27]); ->$BindToVariable_txt)
$SQL_Select_txt:=$SQL_Select_txt+" FROM Inspections WHERE InspID = :RemoteInspID_L INTO "+$BindToVariable_txt+";"
clone_ClearFieldVariables(Table:C252(->[Inspections:27]))
ut_SQLReturnRecord($SQL_Select_txt; "[Inspections]"; String:C10(RemoteInspID_L))

If ((v_27_001_txt#"") & (ut_fTestForSQLor4DError))
	$PrevTransferOpt_L:=<>Transfer  //save transfer pref
	<>Transfer:=-1  // no transfer
	Case of 
		: (Not:C34(INSP_DWNLD_InspRec))
			
		: (Not:C34(SQL_INSPDownloadRecords(->[ElementsSafety:29]ElmSafetyID:7; ->[ElementsSafety:29]InspID:4; ->[Inspections:27]InspID:2; "ElementsSafety"; RemoteInspID_L; INSP_LocalInspID_L)))  //replaced INSP_DWNLD_ElmtsSfty
		: (Not:C34(SQL_INSPDownloadRecords(->[Standard Photos:36]StdPhotoID:7; ->[Standard Photos:36]InspID:1; ->[Inspections:27]InspID:2; "StandardPhotos"; RemoteInspID_L; INSP_LocalInspID_L)))  //replace INSP_DWNLD_Images
		: (Not:C34(SQL_INSPDownloadRecords(->[PON_ELEM_INSP:179]ELEMID:22; ->[PON_ELEM_INSP:179]INSPID:21; ->[Inspections:27]InspID:2; "PON_ELEM_INSP"; RemoteInspID_L; INSP_LocalInspID_L)))
		: (Not:C34(SQL_INSPDownloadRecords(->[TunnelInspection:152]TunnelInspID_L:15; ->[TunnelInspection:152]InspID:1; ->[Inspections:27]InspID:2; "TunnelInspection"; RemoteInspID_L; INSP_LocalInspID_L)))
		: (Not:C34(INSP_DWNLD_ElmtRR_ratings))
		: (Not:C34(INSP_DWNLD_TmMembers))
		: (Not:C34(INSP_DWNLD_PontisRec))
		: (Not:C34(SQL_INSPDownloadRecords(->[Cond Units:45]Cond Unit ID:1; ->[Cond Units:45]Inspection ID:2; ->[BMS Inspections:44]Inspection ID:1; "Cond Unit ID"; INSP_RemoteBMSID_L; INSP_LocalBMSID_L)))  //replace dINSP_DWNLD_CUs
			
		: (Not:C34(INSP_DWNLD_PONTmMembers))
		Else 
			//post process pon_elem_insp records to fix parentid and grandparentids
			//go tthough them and find from fileid res table which is the correct id  and make LNK records
			
			QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]INSPID:21=INSP_LocalInspID_L)
			If (Records in selection:C76([PON_ELEM_INSP:179])>0)
				ut_Message("Adjusting Parent/Grandparent IDs in NBEs..."+<>sCR)
				FIRST RECORD:C50([PON_ELEM_INSP:179])
				While (Not:C34(End selection:C36([PON_ELEM_INSP:179])))
					InitChangeStack(1)
					If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
						ut_Message("Adjusting Parent ID for NBE ID "+String:C10([PON_ELEM_INSP:179]ELEMID:22)+" Key "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+" Env "+String:C10([PON_ELEM_INSP:179]ENVKEY:5)+" Par "+String:C10([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)+" ..."+<>sCR)
						//id in there is from server - need to find which is the new local one
						QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=Table:C252(->[PON_ELEM_INSP:179]); *)
						QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4=<>Destination; *)
						QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination ID:3=String:C10([PON_ELEM_INSP:179]ELEM_PARENTID:27))
						If (Records in selection:C76([FileIDRes Table:60])=1)
							[PON_ELEM_INSP:179]ELEM_PARENTID:27:=Num:C11([FileIDRes Table:60]Local ID:2)
							LogLink(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
						Else 
							//if not found or more than one -error !! set the parent to 0 and the parent key to 0
							ut_Message("ERROR  Parent IDs in NBEs "+String:C10([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)+<>sCR)
							[PON_ELEM_INSP:179]ELEM_PARENTID:27:=0
							[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4:=0
							PushChange(1; ->[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)
							PushChange(1; ->[PON_ELEM_INSP:179]ELEM_PARENTID:27)
							
						End if 
						
					End if 
					If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
						ut_Message("Adjusting GrandParent ID for NBE ID "+String:C10([PON_ELEM_INSP:179]ELEMID:22)+" Key "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+" Env "+String:C10([PON_ELEM_INSP:179]ENVKEY:5)+" Par "+String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19)+" ..."+<>sCR)
						//id in there is from server - need to find which is the new local one
						QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=Table:C252(->[PON_ELEM_INSP:179]); *)
						QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4=<>Destination; *)
						QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination ID:3=String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28))
						If (Records in selection:C76([FileIDRes Table:60])=1)
							[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=Num:C11([FileIDRes Table:60]Local ID:2)
							LogLink(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
						Else 
							ut_Message("ERROR  GrandParent IDs in NBEs "+String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19)+<>sCR)
							//if not found or more than one -error !! set the parentAND grandparent to 0 and the parent key to 0
							[PON_ELEM_INSP:179]ELEM_PARENTID:27:=0
							[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4:=0
							[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=0
							[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19:=0
							PushChange(1; ->[PON_ELEM_INSP:179]ELEM_PARENTID:27)
							PushChange(1; ->[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)
							PushChange(1; ->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28)
							PushChange(1; ->[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19)
							
						End if 
						
					End if 
					FlushGrpChgs(1; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2)
					SAVE RECORD:C53([PON_ELEM_INSP:179])
					NEXT RECORD:C51([PON_ELEM_INSP:179])
				End while 
				
			End if 
			
			//create local Combined record
			ut_Message("Storing local Links..."+<>sCR)
			CREATE RECORD:C68([Combined Inspections:90])
			Inc_Sequence("CombinedInspections"; ->[Combined Inspections:90]ID:6)
			[Combined Inspections:90]BIN:1:=[Bridge MHD NBIS:1]BIN:3
			[Combined Inspections:90]NBISInspID:2:=INSP_LocalInspID_L
			[Combined Inspections:90]BMSInspID:3:=INSP_LocalBMSID_L
			[Combined Inspections:90]InspDate:4:=[Inspections:27]Insp Date:78
			[Combined Inspections:90]InspType:5:=[Inspections:27]Insp Type:6
			
			SAVE RECORD:C53([Combined Inspections:90])
			LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1; "CombinedInspections")
			X_CleanIDResTable(Table:C252(->[Combined Inspections:90]); String:C10(INSP_RemoteCombID_L); "REMOTE")
			G_StoreRecResolution(Table:C252(->[Combined Inspections:90]); String:C10([Combined Inspections:90]ID:6); String:C10(INSP_RemoteCombID_L); <>Destination)
			InitChangeStack(1)
			PushChange(1; ->[Combined Inspections:90]InspDate:4)
			PushChange(1; ->[Combined Inspections:90]InspType:5)
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
			LogLink(->[Combined Inspections:90]NBISInspID:2; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
			LogLink(->[Combined Inspections:90]BMSInspID:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
			ut_Message("Done ..."+<>sCR)
	End case 
	<>Transfer:=$PrevTransferOpt_L  //restore transfer preferece
End if 
$0:=ut_fTestForSQLor4DError