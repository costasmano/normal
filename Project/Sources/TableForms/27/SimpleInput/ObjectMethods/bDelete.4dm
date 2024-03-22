If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/13/05, 10:56:25
	// ----------------------------------------------------
	// Method: Object Method: bDelete
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2005_CM13
End if 

C_TEXT:C284($Text; $ElTxt; $PictTxt)  //Alert message text and parts.
C_LONGINT:C283($NoElems; $NoPicts; $NoCUs)  //Number of Elements ([ElementsSafety] records),
// [Standard Photos] records.
C_BOOLEAN:C305($vBMSInspHere_B; $vCombId_b)
If (ut_LoadRecordInteractive(->[Inspections:27]))
	QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
	$vCombId_b:=(Records in selection:C76([Combined Inspections:90])=1)
	If ($vCombId_b)
		QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
	End if 
	$vBMSInspHere_B:=(Records in selection:C76([BMS Inspections:44])=1)
	If (([Inspections:27]InspApproved:167#BMS Not Reviewed) & ([Inspections:27]InspReviewed:12#BMS Not Reviewed) & (Current user:C182#"Designer"))
		ALERT:C41("Cannot delete an Approved Inspection report!!!!")
	Else 
		$NoElems:=Records in selection:C76([ElementsSafety:29])
		$NoPicts:=Records in selection:C76([Standard Photos:36])
		
		If (([Inspections:27]InspApproved:167#BMS Not Reviewed) | ([Inspections:27]InspReviewed:12#BMS Not Reviewed))
			$Text:="Do you Designer really want to delete this Inspection record, "
			$Text:=$Text+"which is in the Review process,"
		Else 
			$Text:="Do you really want to delete this inspection record"
		End if 
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
		If ($vCombId_b)
			$Text:=$Text+" and a Combined Inspection "+String:C10([Combined Inspections:90]ID:6)+" "
		End if 
		
		If ($vBMSInspHere_B)
			$Text:=$Text+" and a Pontis Inspection "+String:C10([BMS Inspections:44]Inspection ID:1)+" "
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
		
		$Text:=$Text+" ? "
		
		CONFIRM:C162($Text; "DELETE")
		If (OK=1)
			//The relation automatically deletes related many records.
			LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
			
			//Now delete the record  
			DELETE RECORD:C58([Inspections:27])
			
			CANCEL:C270  //Exit the form
			
		End if 
	End if 
Else 
	ALERT:C41("Could not load Inspection record to delete!")
End if 
