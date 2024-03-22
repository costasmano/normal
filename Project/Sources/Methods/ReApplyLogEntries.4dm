//%attributes = {"invisible":true}
If (False:C215)
	//ReApplyLogEntries 
	// Date and time: 03/15/10, 11:28:39
	
	//to be used only in user mode after selecting a list of entries to be re-done.
	//can only reliably be used for inspection related entries only.  if an inspection has been deleted. 
	//if other records were in the middle that created personnel records, this thing might fail. 
	
	Mods_2010_03
	Mods_2011_06  // CJ Miller`06/14/11, 10:39:59      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(2022-03-14T00:00:00 16:23:24)
	Mods_2022_03
	//  `Request only the ID for the [CombinedInspections] record.  Extract the other IDs from LNK records.
	//  `Include search for records related to [ElementsSafety] records
	//  `Continue till the end of list of [activity log] records found, ignoring deletion (DRC) records for 
	//  `[combinedinspections] [inspections] and [bmsinspection] records. 
	
End if 
C_TEXT:C284($CombInspID_s; $InspID_s; $BMSInsp_Id_s)  //<--- Added// Command Replaced was o C STRING length was 20
C_TEXT:C284($msg_txt)
$msg_txt:="This method is designed to recreate all actions recorded for a complete "
$msg_txt:=$msg_txt+"inspection report from start to finish up ignoring deletions"
$msg_txt:=$msg_txt+" of one of the main records from the tables [Combined Inspections], [Inspections]"
$msg_txt:=$msg_txt+", [BMS Inspections].  In the next prompts you should enter the"
$msg_txt:=$msg_txt+" ID for the [Combinedinspection] table that needs to be recreated."
$msg_txt:=$msg_txt+<>sCR+"The method assumes that other needed records in the database exist, such as "
$msg_txt:=$msg_txt+"Personnel for DBIEs, Team Leaders, Team members."
ut_BigAlert($msg_txt)
$CombInspID_s:=Request:C163("Enter Combined inspection ID (table [Combined Inspections])")
If (OK=1)
	C_TEXT:C284($combBIN_)
	C_LONGINT:C283($FirstRefID_L)
	QUERY:C277([Activity Log:59]; [Activity Log:59]Local ID:15=$CombInspID_s)
	QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[Combined Inspections:90]))
	CREATE SET:C116([Activity Log:59]; "REAPPLYCOMBINED")
	//find the [inspections] ID
	C_LONGINT:C283($NBIInspID_L; $BMSINspID_L)
	QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Activity Type:3="LNK"; *)
	QUERY SELECTION:C341([Activity Log:59];  & ; [Activity Log:59]Field Number:8=Field:C253(->[Combined Inspections:90]NBISInspID:2))
	If (Records in selection:C76([Activity Log:59])>0)
		LOAD RECORD:C52([Activity Log:59])
		
		Case of 
			: ([Activity Log:59]Data Type:11=Is longint:K8:6)
				BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $NBIInspID_L)
				$InspID_s:=String:C10($NBIInspID_L)
		End case 
		
	End if 
	
	USE SET:C118("REAPPLYCOMBINED")
	//find the [inspections] ID
	QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Activity Type:3="LNK"; *)
	QUERY SELECTION:C341([Activity Log:59];  & ; [Activity Log:59]Field Number:8=Field:C253(->[Combined Inspections:90]BMSInspID:3))
	If (Records in selection:C76([Activity Log:59])>0)
		ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28; <)  //get the last one - sometimes there is no link to a BMS inspections record at the start, but it gets added later
		LOAD RECORD:C52([Activity Log:59])
		
		Case of 
			: ([Activity Log:59]Data Type:11=Is longint:K8:6)
				BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $BMSINspID_L)
				$BMSInsp_Id_s:=String:C10($BMSINspID_L)
		End case 
		
	End if 
	
	
	//get the parent ID : BIN
	FIRST RECORD:C50([Activity Log:59])
	$combBIN_:=[Activity Log:59]Parent ID:14
	
	QUERY:C277([Activity Log:59]; [Activity Log:59]Local ID:15=$InspID_s)
	QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[Inspections:27]))
	ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28; >)  //make sure the records are sorted
	CREATE SET:C116([Activity Log:59]; "REAPPLYINSP")
	FIRST RECORD:C50([Activity Log:59])
	$FirstRefID_L:=[Activity Log:59]RefID:28  //save the first record RefID - used later when searching for children of [elementssafety]
	
	QUERY:C277([Activity Log:59]; [Activity Log:59]Parent ID:14=$InspID_s)
	QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]FileID Parent:22=Table:C252(->[Inspections:27]))
	CREATE SET:C116([Activity Log:59]; "REAPPLYINSPCHILD")
	
	UNION:C120("REAPPLYCOMBINED"; "REAPPLYINSP"; "REAPPLYCOMBINED")
	UNION:C120("REAPPLYCOMBINED"; "REAPPLYINSPCHILD"; "REAPPLYCOMBINED")
	
	//Elementssafety can have child records
	QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[ElementsSafety:29]))
	ARRAY TEXT:C222($ElmtSftIDs_atxt; 0)
	DISTINCT VALUES:C339([Activity Log:59]Local ID:15; $ElmtSftIDs_atxt)
	
	QUERY:C277([Activity Log:59]; [Activity Log:59]RefID:28>$FirstRefID_L; *)  // get act log records after the first for the Inspections
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Parent:22=Table:C252(->[ElementsSafety:29]))  // and related to [elementssafety]
	QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]Parent ID:14; $ElmtSftIDs_atxt)
	CREATE SET:C116([Activity Log:59]; "REAPPLYINSPCHILD")
	UNION:C120("REAPPLYCOMBINED"; "REAPPLYINSPCHILD"; "REAPPLYCOMBINED")
	
	If ($BMSINspID_L>0)
		
		QUERY:C277([Activity Log:59]; [Activity Log:59]Local ID:15=$BMSInsp_Id_s)
		QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]FileID Local:24=Table:C252(->[BMS Inspections:44]))
		CREATE SET:C116([Activity Log:59]; "REAPPLYINSP")
		
		QUERY:C277([Activity Log:59]; [Activity Log:59]Parent ID:14=$BMSInsp_Id_s)
		QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]FileID Parent:22=Table:C252(->[BMS Inspections:44]))
		CREATE SET:C116([Activity Log:59]; "REAPPLYINSPCHILD")
		
		UNION:C120("REAPPLYCOMBINED"; "REAPPLYINSP"; "REAPPLYCOMBINED")
		UNION:C120("REAPPLYCOMBINED"; "REAPPLYINSPCHILD"; "REAPPLYCOMBINED")
		
	End if 
	
	USE SET:C118("REAPPLYCOMBINED")
	CLEAR SET:C117("REAPPLYCOMBINED")
	CLEAR SET:C117("REAPPLYINSP")
	CLEAR SET:C117("REAPPLYINSPCHILD")
	
	C_TEXT:C284(ActDest)  //<--- Added// Command Replaced was o C STRING length was 80//[Activity Log]Destination
	C_TEXT:C284(ActSource)  //<--- Added// Command Replaced was o C STRING length was 80//[Activity Log]Source
	C_TEXT:C284(ActType)  //<--- Added// Command Replaced was o C STRING length was 3//[Activity Log]Activity Type
	C_TEXT:C284(ActUsrName)  //<--- Added// Command Replaced was o C STRING length was 80//[Activity Log]User Name
	C_DATE:C307(ActDate)  //[Activity Log]dDate
	C_LONGINT:C283(ActFileNo)  //[Activity Log]File Number
	C_LONGINT:C283(ActFldNo)  //[Activity Log]Field Number
	C_LONGINT:C283(ActStatus)  //[Activity Log]Status
	C_BLOB:C604(ActData)  //[Activity Log]Data
	C_LONGINT:C283(ActDataTyp)  //[Activity Log]Data Type
	C_LONGINT:C283(ActTransfer)  //[Activity Log]Transfer
	C_TEXT:C284(ActForward)  //<--- Added// Command Replaced was o C STRING length was 80//[Activity Log]Forward
	C_TEXT:C284(ActParentID)  //<--- Added// Command Replaced was o C STRING length was 20//[Activity Log]Parent ID
	C_TEXT:C284(ActLocalID)  //<--- Added// Command Replaced was o C STRING length was 20//[Activity Log]Local ID
	C_TEXT:C284(ActDestID)  //<--- Added// Command Replaced was o C STRING length was 20//[Activity Log]Dest ID parent
	C_LONGINT:C283(ActTypPar)  //[Activity Log]Type Parent
	C_LONGINT:C283(ActTypLocal)  //[Activity Log]Local Type
	C_TEXT:C284(ActDestLoc)  //<--- Added// Command Replaced was o C STRING length was 20//[Activity Log]Dest ID local
	C_TEXT:C284(ActFldName)  //<--- Added// Command Replaced was o C STRING length was 30//[Activity Log]Field Name
	C_LONGINT:C283(ActFileIDP)  //[Activity Log]FileID Parent
	C_LONGINT:C283(ActFieldIDP)  //[Activity Log]FieldID Parent
	C_LONGINT:C283(ActFileIDL)  //[Activity Log]FileID Local
	C_LONGINT:C283(ActFieldIDL)  //[Activity Log]FieldID Local
	C_LONGINT:C283(ActRefIDTyp)  //Command Replaced was o C INTEGER//[Activity Log]RefIDType
	C_BLOB:C604(ActOldData)  //[Activity Log]Old Data
	C_LONGINT:C283(ActRefID)  //[Activity Log]RefID
	
	C_TEXT:C284(vsForward)  //<--- Added// Command Replaced was o C STRING length was 80
	vsForward:=<>Forward
	
	C_LONGINT:C283($vlnumlogs)
	C_TEXT:C284(REAPPLY_FILEIDRES_SET)
	REAPPLY_FILEIDRES_SET:="REAPPLY_FILEIDRES_SET"
	$vlnumlogs:=Records in selection:C76([Activity Log:59])
	
	If ($vlnumlogs>0)
		//make sure the report is for a single BIN.
		
		CONFIRM:C162("Re-Do "+String:C10($vlnumlogs)+" [Activity Log] records for Inspection for BIN "+$combBIN_+"?")
		If (OK=1)
			ALERT:C41("On the next prompt please enter the correct data for Forward field")
			vsForward:=Synch_ReturnForward(""; ""; ""; 0)  // need to enter Forward info
			CONFIRM:C162("Proceed with Forward = "+vsForward+"?"; "Proceed"; "Abort Replay")
			If (Ok=1)
				CREATE EMPTY SET:C140([FileIDRes Table:60]; REAPPLY_FILEIDRES_SET)
				ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28)
				C_LONGINT:C283($viOnScreen)  //Command Replaced was o C INTEGER
				CONFIRM:C162("View messages on screen or log to file?"; "OnScreen"; "File and Screen")
				If (OK=1)
					$viOnScreen:=1
				Else 
					$viOnScreen:=3
				End if 
				ut_StartMessage($viOnScreen; "Replay log")
				FIRST RECORD:C50([Activity Log:59])
				C_LONGINT:C283($i)
				For ($i; 1; $vlnumlogs)
					COPY NAMED SELECTION:C331([Activity Log:59]; "SELECTEDACTLOG")
					
					ActDest:=[Activity Log:59]Destination:1
					ActSource:=[Activity Log:59]Source:2
					ActType:=[Activity Log:59]Activity Type:3
					ActUsrName:=[Activity Log:59]User Name:4
					ActDate:=[Activity Log:59]dDate:5
					ActFileNo:=[Activity Log:59]File Number:7
					ActFldNo:=[Activity Log:59]Field Number:8
					ActStatus:=[Activity Log:59]Status:9
					ActData:=[Activity Log:59]Data:10
					ActDataTyp:=[Activity Log:59]Data Type:11
					ActTransfer:=[Activity Log:59]Transfer:12
					ActForward:=[Activity Log:59]Forward:13
					ActParentID:=[Activity Log:59]Parent ID:14
					ActLocalID:=[Activity Log:59]Local ID:15
					ActDestID:=[Activity Log:59]Dest ID parent:16
					ActTypPar:=[Activity Log:59]Type Parent:17
					ActTypLocal:=[Activity Log:59]Local Type:18
					ActDestLoc:=[Activity Log:59]Dest ID local:19
					ActFldName:=[Activity Log:59]ActField Name:20
					ActFileIDP:=[Activity Log:59]FileID Parent:22
					ActFieldIDP:=[Activity Log:59]FieldID Parent:23
					ActFileIDL:=[Activity Log:59]FileID Local:24
					ActFieldIDL:=[Activity Log:59]FieldID Local:25
					ActRefIDTyp:=[Activity Log:59]RefIDType:26
					ActOldData:=[Activity Log:59]Old Data:27
					ActRefID:=[Activity Log:59]RefID:28
					
					Case of 
						: ([Activity Log:59]Activity Type:3="NRC")
							ut_Message("ReLoading NRC RefID = "+String:C10([Activity Log:59]RefID:28)+<>sCR)
							ReApplyNRC
						: ([Activity Log:59]Activity Type:3="DRC")
							Case of 
								: ([Activity Log:59]FileID Local:24=Table:C252(->[Inspections:27]))
									ut_Message("Ignoring DRC RefID = "+String:C10([Activity Log:59]RefID:28)+<>sCR)
									
								: ([Activity Log:59]FileID Local:24=Table:C252(->[Combined Inspections:90]))
									ut_Message("Ignoring DRC RefID = "+String:C10([Activity Log:59]RefID:28)+<>sCR)
									
								: ([Activity Log:59]FileID Local:24=Table:C252(->[BMS Inspections:44]))
									ut_Message("Ignoring DRC RefID = "+String:C10([Activity Log:59]RefID:28)+<>sCR)
									
								Else 
									ut_Message("ReLoading DRC RefID = "+String:C10([Activity Log:59]RefID:28)+<>sCR)
									ReApplyDRC
							End case 
							
						: ([Activity Log:59]Activity Type:3="FLD")
							ut_Message("ReLoading FLD RefID = "+String:C10([Activity Log:59]RefID:28)+<>sCR)
							ReApplyFLD
						: ([Activity Log:59]Activity Type:3="GRP")
							ut_Message("ReLoading GRP RefID = "+String:C10([Activity Log:59]RefID:28)+<>sCR)
							ReApplyGRP
						: ([Activity Log:59]Activity Type:3="LNK")
							ut_Message("ReLoading LNK RefID = "+String:C10([Activity Log:59]RefID:28)+<>sCR)
							ReApplyLNK
						: ([Activity Log:59]Activity Type:3="GRD")
							ut_Message("ReLoading GRD RefID = "+String:C10([Activity Log:59]RefID:28)+<>sCR)
							ReApplyGRD
							
					End case 
					//FLUSH CACHE
					USE NAMED SELECTION:C332("SELECTEDACTLOG")
					NEXT RECORD:C51([Activity Log:59])
				End for   //end of record loop    
				CLEAR NAMED SELECTION:C333("SELECTEDACTLOG")
				If (Records in set:C195(REAPPLY_FILEIDRES_SET)>0)
					ut_Message("Clearing File ID Res entries.."+Char:C90(13))
					USE SET:C118(REAPPLY_FILEIDRES_SET)
					DELETE SELECTION:C66([FileIDRes Table:60])
				End if 
				CLEAR SET:C117(REAPPLY_FILEIDRES_SET)
				ut_CloseMessage
				
			End if 
		End if   //if user OK'd redo
	Else 
		ALERT:C41("No Activity Log Records found for the specified Inspection record IDs CombinedID="+$CombInspID_s+", InspID="+$InspID_s+", BMSInspID="+$BMSInsp_Id_s+"!")
	End if   //if there are selected records
End if 