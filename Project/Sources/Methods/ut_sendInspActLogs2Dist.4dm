//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/15/11, 17:00:25
	// ----------------------------------------------------
	// Method: ut_sendInspActLogs2Dist
	// Description
	//  ` Designate Act Log records to be received by a District.  to be run on Boston server
	// 
	// Parameters
	// $1 : $IinspID_L
	// $2 : $CombInspID_L
	// $3 : $BMSInspID_L
	// $4 : $DistrNo_L
	// ----------------------------------------------------
	
	Mods_2011_09
End if 
If (Count parameters:C259>0)
	C_LONGINT:C283($1; $IinspID_L; $2; $CombInspID_L; $3; $BMSInspID_L; $4; $DistrNo_L)
	$IinspID_L:=$1
	$CombInspID_L:=$2
	$BMSInspID_L:=$3
	$DistrNo_L:=$4
	
	C_LONGINT:C283($tableNo_L; $parentTbl_L)
	C_TEXT:C284($InspID_txt)
	
	$tableNo_L:=Table:C252(->[Inspections:27])
	$InspID_txt:=String:C10($IinspID_L)
	SET QUERY DESTINATION:C396(Into set:K19:2; "ActLogRecs")
	QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$tableNo_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Local ID:15=$InspID_txt)
	SET QUERY DESTINATION:C396(Into set:K19:2; "Children")
	$tableNo_L:=Table:C252(->[Field Trip:43])
	$parentTbl_L:=Table:C252(->[Inspections:27])
	QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$tableNo_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Parent:22=$parentTbl_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Parent ID:14=$InspID_txt)
	UNION:C120("Children"; "ActLogRecs"; "ActLogRecs")
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "Children")
	$tableNo_L:=Table:C252(->[ElementsSafety:29])
	QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$tableNo_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Parent:22=$parentTbl_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Parent ID:14=$InspID_txt)
	UNION:C120("Children"; "ActLogRecs"; "ActLogRecs")
	
	$tableNo_L:=Table:C252(->[Standard Photos:36])
	QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$tableNo_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Parent:22=$parentTbl_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Parent ID:14=$InspID_txt)
	UNION:C120("Children"; "ActLogRecs"; "ActLogRecs")
	
	$tableNo_L:=Table:C252(->[BMS Inspections:44])
	$InspID_txt:=String:C10($BMSInspID_L)
	SET QUERY DESTINATION:C396(Into set:K19:2; "BMSInsp")
	QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$tableNo_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Local ID:15=$InspID_txt)
	UNION:C120("BMSInsp"; "ActLogRecs"; "ActLogRecs")
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "Children")
	$tableNo_L:=Table:C252(->[BMS Field Trip:56])
	$parentTbl_L:=Table:C252(->[BMS Inspections:44])
	QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$tableNo_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Parent:22=$parentTbl_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Parent ID:14=$InspID_txt)
	UNION:C120("Children"; "ActLogRecs"; "ActLogRecs")
	SET QUERY DESTINATION:C396(Into set:K19:2; "Children")
	$tableNo_L:=Table:C252(->[Cond Units:45])
	$parentTbl_L:=Table:C252(->[BMS Inspections:44])
	QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$tableNo_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Parent:22=$parentTbl_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Parent ID:14=$InspID_txt)
	UNION:C120("Children"; "ActLogRecs"; "ActLogRecs")
	
	$tableNo_L:=Table:C252(->[Combined Inspections:90])
	$InspID_txt:=String:C10($CombInspID_L)
	SET QUERY DESTINATION:C396(Into set:K19:2; "BMSInsp")
	QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$tableNo_L; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Local ID:15=$InspID_txt)
	UNION:C120("BMSInsp"; "ActLogRecs"; "ActLogRecs")
	
	USE SET:C118("ActLogRecs")
	CLEAR SET:C117("ActLogRecs")
	CLEAR SET:C117("Children")
	CLEAR SET:C117("BMSInsp")
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	C_LONGINT:C283($Recs_L; $RecsWDest_L)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $Recs_L)
	QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Destination:1="District "+String:C10($DistrNo_L)+" BMS")
	
	SET QUERY DESTINATION:C396(Into variable:K19:4; $RecsWDest_L)
	QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Destination:1#"")
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	Case of 
		: ($Recs_L>0)
			ALERT:C41("There are some "+String:C10($Recs_L)+" act log records already sent to D"+String:C10($DistrNo_L)+" !!!!")
			
		: ($RecsWDest_L>0)
			ALERT:C41("There are some "+String:C10($RecsWDest_L)+" act log records with other Destinations !!!!")
			
		Else 
			START TRANSACTION:C239
			APPLY TO SELECTION:C70([Activity Log:59]; [Activity Log:59]Destination:1:="District "+String:C10($DistrNo_L)+" BMS")
			CONFIRM:C162("Commit the change to destination = District "+String:C10($DistrNo_L)+" BMS")
			If (Ok=1)
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
			End if 
			
	End case 
	
Else 
	C_LONGINT:C283($IinspID_L; $CombInspID_L; $BMSInspID_L; $DistrNo_L)
	
	//Find which inspection to send
	
	//Find which district
	C_TEXT:C284($Dist_txt)
	$Dist_txt:=Request:C163("Specify District number")
	If ((Int:C8(Num:C11($Dist_txt))>0) & (Int:C8(Num:C11($Dist_txt))<6))
		
		//call myself
		ut_sendInspActLogs2Dist($IinspID_L; $CombInspID_L; $BMSInspID_L; Int:C8(Num:C11($Dist_txt)))
	Else 
		ALERT:C41("Bad District Number "+$Dist_txt)
		
	End if 
	
End if 