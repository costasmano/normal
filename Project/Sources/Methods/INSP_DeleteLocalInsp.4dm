//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/20/06, 08:34:07
	// ----------------------------------------------------
	// Method: INSP_DeleteLocalInsp
	// Description
	// Delete the current local inspection. Called mainly from INSP_DownloadMissing method
	// 
	// Parameters
	// $0 : DeletedOK_b 
	// ----------------------------------------------------
	
	Mods_2007_CM03
	// Modified by: costasmanousakis-(Designer)-(12/17/07 09:02:12)
	Mods_2007_CM_5401
	//  `Fix in FlushGrpDeletions code
	// Modified by: costasmanousakis-(Designer)-(8/11/08 10:38:03)
	Mods_2008_CM_5404  // ("INSPDWNLD")
	//  `1-Any deletion log entries do not get transfered back to the server.
	//  `2-Added calls to clear the [FileIDRes table] from entries related to the inspection 
	//  `being deleted. This method is called when downloading inspections from the server
	//  `and  a local inspection is being replaced by the one on the server.  New [FileIDRes] entries
	//  `will be generated when the server inspection gets copied down to the local DB.
	
	// Modified by: Costas Manousakis-()-(12/2/11 19:09:19)
	Mods_2010_12
	//  `Set up for batch down load
End if 

C_BOOLEAN:C305($0; $DeletedOK_b)
$DeletedOK_b:=False:C215
QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
If ([Combined Inspections:90]BMSInspID:3>0)
	QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
	GOTO SELECTED RECORD:C245([BMS Inspections:44]; 1)
	LOAD RECORD:C52([BMS Inspections:44])
	QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=[BMS Inspections:44]Inspection ID:1)
Else 
	UNLOAD RECORD:C212([BMS Inspections:44])
End if 
C_TEXT:C284($Text; $ElTxt; $PictTxt)  //Alert message text and parts.
C_LONGINT:C283($NoElems; $NoPicts; $NoCUs)  //Number of Elements ([ElementsSafety] records),
// [Standard Photos] records.
C_BOOLEAN:C305($vBMSInspHere_B)
$vBMSInspHere_B:=Is record loaded:C669([BMS Inspections:44])
SET QUERY DESTINATION:C396(Into variable:K19:4; $NoElems)  // do this in case selection has been trimmed down
QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
$NoPicts:=Records in selection:C76([Standard Photos:36])
QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)

$Text:="Do you really want to delete this "+[Inspection Type:31]Description:2+" inspection dated:  "+String:C10([Inspections:27]Insp Date:78; Internal date short:K1:7)
UNLOAD RECORD:C212([Inspection Type:31])

$ElTxt:=""
$PictTxt:=""
Case of 
	: ($NoElems=1)
		$ElTxt:=" its element"
	: ($NoElems>1)
		$ElTxt:=" its "+String:C10($NoElems)+" elements"
End case 
Case of 
	: ($NoPicts=1)
		$PictTxt:=" its image"
	: ($NoPicts>1)
		$PictTxt:=" its "+String:C10($NoPicts)+" images"
End case 

If (($ElTxt+$PictTxt)#"")
	Case of 
		: ($PictTxt#"")
			$Text:=$Text+$ElTxt+" and"+$PictTxt
		: ($PictTxt="")
			$Text:=$Text+" and"+$ElTxt
	End case 
	
End if 
If ($vBMSInspHere_B)
	$Text:=$Text+" and a Pontis Inspection"
	$NoCUs:=Records in selection:C76([Cond Units:45])
	$ElTxt:=""
	Case of 
		: ($NoCUs=1)
			$ElTxt:=" with its Condition Unit"
		: ($NoCUs>1)
			$ElTxt:=" with its "+String:C10($NoCUs)+" Condition Units"
	End case 
	$Text:=$Text+$ElTxt
End if 

$Text:=$Text+"?"
C_BOOLEAN:C305($DoDelete_b)
If (Not:C34(INSP_BatchDownload_b))
	CONFIRM:C162($Text; "DELETE")
	$DoDelete_b:=(OK=1)
Else 
	$DoDelete_b:=INSP_BatchDownload_b
End if 
If ($DoDelete_b)
	C_LONGINT:C283($PrevTransferOpt_L)
	$PrevTransferOpt_L:=<>Transfer  //save transfer pref
	<>Transfer:=-1  // no transfer
	
	//Clear the FileIDRes table of any entries related to the deleted inspection-
	//New links will be made.
	LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
	LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
	X_CleanIDResTable(Table:C252(->[Inspections:27]); String:C10([Inspections:27]InspID:2); "LOCAL")
	X_CleanIDResTable(Table:C252(->[Combined Inspections:90]); String:C10([Combined Inspections:90]ID:6); "LOCAL")
	G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1)
	FIRST RECORD:C50([ElementsSafety:29])
	While (Not:C34(End selection:C36([ElementsSafety:29])))
		X_CleanIDResTable(Table:C252(->[ElementsSafety:29]); String:C10([ElementsSafety:29]ElmSafetyID:7); "LOCAL")
		NEXT RECORD:C51([ElementsSafety:29])
	End while 
	FIRST RECORD:C50([Standard Photos:36])
	While (Not:C34(End selection:C36([Standard Photos:36])))
		X_CleanIDResTable(Table:C252(->[Standard Photos:36]); String:C10([Standard Photos:36]StdPhotoID:7); "LOCAL")
		NEXT RECORD:C51([Standard Photos:36])
	End while 
	
	If ($vBMSInspHere_B)
		LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
		X_CleanIDResTable(Table:C252(->[BMS Inspections:44]); String:C10([BMS Inspections:44]Inspection ID:1); "LOCAL")
		QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=[BMS Inspections:44]Inspection ID:1)
		C_LONGINT:C283($NumCUS_L; $iCUs)
		$NumCUS_L:=Records in selection:C76([Cond Units:45])
		If ($NumCUS_L>0)
			InitGrpDelete
			For ($iCUs; 1; $NumCUS_L)
				GOTO SELECTED RECORD:C245([Cond Units:45]; $iCUs)
				X_CleanIDResTable(Table:C252(->[Cond Units:45]); String:C10([Cond Units:45]Cond Unit ID:1); "LOCAL")
				PushGrpDelete(->[Cond Units:45]Cond Unit ID:1)
			End for 
			FlushGrpDeletions(->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2)
		End if 
	End if 
	
	//Now delete the record  
	//The relation automatically deletes related many records.
	Case of 
		: (Not:C34(ut_LoadRecordInteractive(->[Inspections:27])))
		: (Not:C34(ut_LoadRecordInteractive(->[Combined Inspections:90])))
		Else 
			DELETE RECORD:C58([Inspections:27])
			DELETE RECORD:C58([Combined Inspections:90])
			$DeletedOK_b:=True:C214
			If ($vBMSInspHere_B)
				If (ut_LoadRecordInteractive(->[BMS Inspections:44]))
					DELETE RECORD:C58([BMS Inspections:44])
					If (Records in selection:C76([Cond Units:45])>0)
						DELETE SELECTION:C66([Cond Units:45])
					End if 
				Else 
					$DeletedOK_b:=False:C215
				End if 
				
			End if 
			
	End case 
	
End if 

<>Transfer:=$PrevTransferOpt_L  // restore the original value

$0:=$DeletedOK_b