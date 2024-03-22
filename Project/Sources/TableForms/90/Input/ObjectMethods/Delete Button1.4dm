If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/11/05, 14:35:24
	// ----------------------------------------------------
	// Method: Object Method: CombDelButton
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM11
	Mods_2005_CM15
End if 

C_LONGINT:C283($numNBIRecs; $numBMSRecs; $BMSInspID; $NBIInspID)
C_TEXT:C284($CurrentBIN)  // Command Replaced was o_C_STRING length was 3
$CurrentBIN:=[Combined Inspections:90]BIN:1
SET QUERY DESTINATION:C396(Into variable:K19:4; $numNBIRecs)
QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
SET QUERY DESTINATION:C396(Into variable:K19:4; $numBMSRecs)
QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
C_TEXT:C284($msg)
$msg:="Delete the current Combined Record?"
If ($numNBIRecs>0)
	$msg:=$msg+" ( there is "+String:C10($numNBIRecs)+" existing NBI Insp. "+String:C10([Combined Inspections:90]NBISInspID:2)+")"
	$NBIInspID:=[Combined Inspections:90]NBISInspID:2
End if 
If ($numBMSRecs>0)
	$msg:=$msg+" ( there is "+String:C10($numBMSRecs)+" existing BMS Insp."+String:C10([Combined Inspections:90]BMSInspID:3)+")"
	$BMSInspID:=[Combined Inspections:90]BMSInspID:3
End if 

CONFIRM:C162($msg)
If (OK=1)
	LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
	DELETE RECORD:C58([Combined Inspections:90])
	If ($numBMSRecs>0)
		CONFIRM:C162("Delete related BMS Inspection ID : "+String:C10($BMSInspID))
		If (OK=1)
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=$BMSInspID)
			If ([BMS Inspections:44]BIN:2=$CurrentBIN)
				LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
				DELETE RECORD:C58([BMS Inspections:44])
			Else 
				ALERT:C41("BMS inspection does not have same BIN! (BMS BIN "+[BMS Inspections:44]BIN:2+" # "+$CurrentBIN+")")
			End if 
			
		End if 
	End if 
	If ($numNBIRecs>0)
		CONFIRM:C162("Delete related NBI Inspection ID : "+String:C10($NBIInspID))
		If (OK=1)
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$NBIInspID)
			If ([Inspections:27]BIN:1=$CurrentBIN)
				LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
				DELETE RECORD:C58([Inspections:27])
			Else 
				ALERT:C41("NBI inspection does not have same BIN! (BMS BIN "+[Inspections:27]BIN:1+" # "+$CurrentBIN+")")
			End if 
			
		End if 
	End if 
	CANCEL:C270
	
End if 