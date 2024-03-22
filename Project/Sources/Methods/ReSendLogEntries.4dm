//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// Method: ReSendLogEntries
	// Description
	// Resend Activity Log Entries
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	
	Mods_2005_CM15
	// Modified by: costasmanousakis-(Designer)-(5/1/2007 15:38:50)
	Mods_2007_CM09
	// Modified by: costasmanousakis-(Designer)-(8/11/08 10:20:45)
	Mods_2008_CM_5404  // ("Various")
	//use method X_CleanIDResTable
End if 

C_LONGINT:C283($vlStartID)
C_TEXT:C284($vsStartID)  //<--- Added// Command Replaced was o_C_STRING length was 40
C_BOOLEAN:C305($vbStartID; $vbInspID; $vbPontisID; $vbCombInspID)
C_LONGINT:C283($vlNumInspRecs; $vlNumPontRecs; $vlNumCombRecs)
//clear act log selection if any
REDUCE SELECTION:C351([Activity Log:59]; 0)

C_LONGINT:C283($fwidth; $fheight)
FORM GET PROPERTIES:C674([Dialogs:21]; "ReSendActLog"; $fwidth; $fheight)
NewWindow($fwidth; $fheight; 6; Plain window:K34:13)
DIALOG:C40([Dialogs:21]; "ReSendActLog")
CLOSE WINDOW:C154

$vbStartID:=(vsStartRefID#"")
$vbInspID:=(vsInspID#"")
$vbPontisID:=(vsBMSInspID#"")
$vbCombInspID:=(vsCombInspID#"")
Case of 
	: ($vbStartID)
		//look for entries sent gt= to number
		//Ask for number starting
		$vlStartID:=Num:C11(vsStartRefID)
		SET CURSOR:C469(4)
		QUERY:C277([Activity Log:59]; [Activity Log:59]RefID:28>=$vlStartID)
		QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Status:9#0)
		QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Source:2#<>Destination)
		SET CURSOR:C469(0)
	: ($vbInspID | $vbPontisID | $vbCombInspID)
		
		CREATE EMPTY SET:C140([Activity Log:59]; "$ActLogInspRecs")
		CREATE EMPTY SET:C140([Activity Log:59]; "$ActLogBMSInspRecs")
		CREATE EMPTY SET:C140([Activity Log:59]; "$ActLogCombInspRecs")
		
		If ($vbInspID)
			C_LONGINT:C283($vlTableID)
			SET CURSOR:C469(4)
			$vlTableID:=Table:C252(->[Inspections:27])
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$vlTableID)
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Local ID:15=vsInspID)
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Source:2#<>Destination)
			If (Records in selection:C76([Activity Log:59])>0)
				CREATE SET:C116([Activity Log:59]; "$ActLogInspIDrecs")
				$vlTableID:=Table:C252(->[ElementsSafety:29])
				QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$vlTableID)
				QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Parent ID:14=vsInspID)
				QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Source:2#<>Destination)
				CREATE SET:C116([Activity Log:59]; "$ActLogInspElmtsRecs")
				$vlTableID:=Table:C252(->[Standard Photos:36])
				QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$vlTableID)
				QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Parent ID:14=vsInspID)
				QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Source:2#<>Destination)
				CREATE SET:C116([Activity Log:59]; "$ActLogInspImgsRecs")
				UNION:C120("$ActLogInspIDrecs"; "$ActLogInspElmtsRecs"; "$ActLogInspRecs")
				UNION:C120("$ActLogInspRecs"; "$ActLogInspImgsRecs"; "$ActLogInspRecs")
				CLEAR SET:C117("$ActLogInspIDrecs")
				CLEAR SET:C117("$ActLogInspElmtsRecs")
				CLEAR SET:C117("$ActLogInspImgsRecs")
			End if 
			SET CURSOR:C469(0)
		End if 
		
		If ($vbPontisID)
			C_LONGINT:C283($vlTableID)
			SET CURSOR:C469(4)
			$vlTableID:=Table:C252(->[BMS Inspections:44])
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$vlTableID)
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Local ID:15=vsBMSInspID)
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Source:2#<>Destination)
			If (Records in selection:C76([Activity Log:59])>0)
				CREATE SET:C116([Activity Log:59]; "$ActLogInspIDrecs")
				$vlTableID:=Table:C252(->[Cond Units:45])
				QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$vlTableID)
				QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Parent ID:14=vsBMSInspID)
				QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Source:2#<>Destination)
				CREATE SET:C116([Activity Log:59]; "$ActLogInspElmtsRecs")
				UNION:C120("$ActLogInspIDrecs"; "$ActLogInspElmtsRecs"; "$ActLogBMSInspRecs")
				CLEAR SET:C117("$ActLogInspIDrecs")
				CLEAR SET:C117("$ActLogInspElmtsRecs")
			End if 
			SET CURSOR:C469(0)
		End if 
		
		If ($vbCombInspID)
			C_LONGINT:C283($vlTableID)
			SET CURSOR:C469(4)
			$vlTableID:=Table:C252(->[Combined Inspections:90])
			QUERY:C277([Activity Log:59]; [Activity Log:59]FileID Local:24=$vlTableID)
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Local ID:15=vsCombInspID)
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Source:2#<>Destination)
			CREATE SET:C116([Activity Log:59]; "$ActLogCombInspRecs")
		End if 
		//combine all inspection sets
		$vlNumInspRecs:=Records in set:C195("$ActLogInspRecs")
		$vlNumPontRecs:=Records in set:C195("$ActLogBMSInspRecs")
		$vlNumCombRecs:=Records in set:C195("$ActLogCombInspRecs")
		UNION:C120("$ActLogBMSInspRecs"; "$ActLogCombInspRecs"; "$ActLogCombInspRecs")
		UNION:C120("$ActLogInspRecs"; "$ActLogCombInspRecs"; "$ActLogCombInspRecs")
		CLEAR SET:C117("$ActLogInspRecs")
		CLEAR SET:C117("$ActLogBMSInspRecs")
		USE SET:C118("$ActLogCombInspRecs")
		CLEAR SET:C117("$ActLogCombInspRecs")
End case 

If (Records in selection:C76([Activity Log:59])=0)
	Case of 
		: ($vbStartID)
			ALERT:C41("No Sent Activity log records found for RefIDs >= "+String:C10($vlStartID))
		: ($vbInspID | $vbPontisID | $vbCombInspID)
			C_TEXT:C284($msg)
			$msg:="No Sent Activity log records found for "
			If ($vbInspID)
				$msg:=$msg+"  Insp ID = <"+vsInspID+">"
			End if 
			If ($vbPontisID)
				$msg:=$msg+"  Pontis Insp ID = <"+vsBMSInspID+">"
			End if 
			If ($vbCombInspID)
				$msg:=$msg+"  Combined Insp ID = <"+vsCombInspID+">"
			End if 
			ALERT:C41($msg)
	End case 
Else 
	
	//start a transcaction
	START TRANSACTION:C239
	CREATE SET:C116([Activity Log:59]; "$ActRecsToReSend")  //save the set
	C_LONGINT:C283($vlActRecs)
	$vlActRecs:=Records in set:C195("$ActRecsToReSend")
	SET CURSOR:C469(4)
	//find NRC records
	QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Activity Type:3="NRC")
	ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28)
	ARRAY TEXT:C222($asLocalIDs; 0)  //Command Replaced was o_ARRAY string length was 20
	ARRAY LONGINT:C221($alLocalTbls; 0)
	SELECTION TO ARRAY:C260([Activity Log:59]Local ID:15; $asLocalIDs; [Activity Log:59]FileID Local:24; $alLocalTbls)
	//find records in FileIDRes table that need to be cleared
	C_LONGINT:C283($i; $vlNumNRCs)
	$vlNumNRCs:=Size of array:C274($asLocalIDs)
	C_TEXT:C284($vsLocIDresolution)  //<--- Added// Command Replaced was o_C_STRING length was 80//to match ids in FileIDRes Table
	For ($i; 1; $vlNumNRCs)
		$vsLocIDresolution:=$asLocalIDs{$i}
		X_CleanIDResTable($alLocalTbls{$i}; $vsLocIDresolution; "LOCAL")
	End for 
	USE SET:C118("$ActRecsToReSend")
	CLEAR SET:C117("$ActRecsToReSend")
	QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]RefIDType:26#0)  //these IDs are global so we don't need to change them.
	APPLY TO SELECTION:C70([Activity Log:59]; [Activity Log:59]Status:9:=0)
	APPLY TO SELECTION:C70([Activity Log:59]; [Activity Log:59]Dest ID local:19:="")
	APPLY TO SELECTION:C70([Activity Log:59]; [Activity Log:59]Dest ID parent:16:="")
	SET CURSOR:C469(0)
	
	If (Records in set:C195("LockedSet")=0)
		VALIDATE TRANSACTION:C240
		If ($vbStartID)
			ALERT:C41("Reset "+String:C10($vlActRecs)+" Activity log records")
		Else 
			C_TEXT:C284($msg)
			$msg:="Reset "
			If ($vlNumCombRecs>0)
				$msg:=$msg+String:C10($vlNumCombRecs)+" Combine_Insp ID:<"+vsCombInspID+"> "
			End if 
			If ($vlNumInspRecs>0)
				$msg:=$msg+String:C10($vlNumInspRecs)+" NBI_Insp  ID:<"+vsInspID+"> "
			End if 
			If ($vlNumPontRecs>0)
				$msg:=$msg+String:C10($vlNumPontRecs)+" Pontis_Insp  ID:<"+vsBMSInspID+"> "
				$msg:=$msg+"  Activity log records"
				ALERT:C41($msg)
			End if 
		End if   //if re-set Act log entries by RefID only 
	Else 
		CANCEL TRANSACTION:C241
		ALERT:C41("Some Activity log records were locked! Reset canceled!")
	End if 
	//FLUSH CACHE
End if   //if found some records in Activity log