//%attributes = {"invisible":true}
If (False:C215)
	//procedure: SetupCombined
	//by: Albert Leung
	//created: 11/18/2004
	//modified:
	//purpose: create Combined Inspection records for all inspections.
	//This does not create any logs. If you run it again you have to delete all
	//[Inspections] with record type = "PON" before running.
End if 

If (Current user:C182="designer")
	C_LONGINT:C283($vlRecord; $vlFound)
	C_DATE:C307($vdInspDate; $vdInspDate_min; $vdInspDate_max)
	C_TEXT:C284($vsBIN; $vsInspType)  // Command Replaced was o_C_STRING length was 3
	C_LONGINT:C283($vlNBISInspID; $vlBMSInspID; $vlDupFound; $vlWorkingInsps)
	C_BOOLEAN:C305($err; $vbPickfirstPontis)
	C_TEXT:C284($vtBadBINS)
	
	$vlFound:=0
	$vlDupFound:=0
	$vtBadBINS:=""
	//Look at all the Inspections and see if there is a
	//matching Pontis inspection
	ALL RECORDS:C47([Inspections:27])
	FIRST RECORD:C50([Inspections:27])
	CONFIRM:C162("Pick first pontis found?")
	$vbPickfirstPontis:=(OK=1)
	SHORT_MESSAGE("Starting BMS Inspections")
	$vlWorkingInsps:=Records in selection:C76([Inspections:27])
	For ($vlRecord; 1; $vlWorkingInsps)
		MESSAGE:C88(<>sCR+String:C10($vlRecord)+" of "+String:C10($vlWorkingInsps))
		$vdInspDate:=[Inspections:27]Insp Date:78
		$vdInspDate_min:=$vdInspDate-7
		$vdInspDate_max:=$vdInspDate+7
		$vsBIN:=[Inspections:27]BIN:1
		$vlNBISInspID:=[Inspections:27]InspID:2
		$vsInspType:=[Inspections:27]Insp Type:6
		If (($vsInspType="RTN") | ($vsInspType="RTA") | ($vsInspType="CUL"))
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4>=$vdInspDate_min; *)
			QUERY:C277([BMS Inspections:44];  & ; [BMS Inspections:44]Insp Date:4<=$vdInspDate_max; *)
			QUERY:C277([BMS Inspections:44];  & ; [BMS Inspections:44]BIN:2=$vsBIN)
			$vlFound:=Records in selection:C76([BMS Inspections:44])
		Else 
			$vlFound:=0
		End if 
		
		If ($vlFound=1)
			//Create a Combined Inspection record    
			CREATE RECORD:C68([Combined Inspections:90])
			Inc_Sequence("CombinedInspections"; ->[Combined Inspections:90]ID:6)
			[Combined Inspections:90]BIN:1:=$vsBIN
			[Combined Inspections:90]NBISInspID:2:=$vlNBISInspID
			[Combined Inspections:90]BMSInspID:3:=[BMS Inspections:44]Inspection ID:1
			[Combined Inspections:90]InspDate:4:=$vdInspDate
			[Combined Inspections:90]InspType:5:=$vsInspType
			SAVE RECORD:C53([Combined Inspections:90])
		End if 
		If ($vlFound=0)
			//Deal with single NBIS Inspections
			//Create a Combined Inspection record    
			CREATE RECORD:C68([Combined Inspections:90])
			Inc_Sequence("CombinedInspections"; ->[Combined Inspections:90]ID:6)
			[Combined Inspections:90]BIN:1:=$vsBIN
			[Combined Inspections:90]NBISInspID:2:=$vlNBISInspID
			[Combined Inspections:90]BMSInspID:3:=-1
			[Combined Inspections:90]InspDate:4:=$vdInspDate
			[Combined Inspections:90]InspType:5:=$vsInspType
			SAVE RECORD:C53([Combined Inspections:90])
		End if 
		If ($vlFound>1)
			$err:=True:C214
			$vlDupFound:=$vlDupFound+1
			$vtBadBINS:=$vtBadBINS+"-"+$vsBIN
			If ($vbPickfirstPontis)
				FIRST RECORD:C50([BMS Inspections:44])
				LOAD RECORD:C52([BMS Inspections:44])
				//Create a Combined Inspection record    
				CREATE RECORD:C68([Combined Inspections:90])
				Inc_Sequence("CombinedInspections"; ->[Combined Inspections:90]ID:6)
				[Combined Inspections:90]BIN:1:=$vsBIN
				[Combined Inspections:90]NBISInspID:2:=$vlNBISInspID
				[Combined Inspections:90]BMSInspID:3:=[BMS Inspections:44]Inspection ID:1
				[Combined Inspections:90]InspDate:4:=$vdInspDate
				[Combined Inspections:90]InspType:5:=$vsInspType
				SAVE RECORD:C53([Combined Inspections:90])
				
			End if 
			
		End if 
		NEXT RECORD:C51([Inspections:27])
	End for 
	CLOSE WINDOW:C154
	//Deal with single BMS Inspections
	ALL RECORDS:C47([BMS Inspections:44])
	FIRST RECORD:C50([BMS Inspections:44])
	SHORT_MESSAGE("Starting Pontis Inspections")
	$vlWorkingInsps:=Records in selection:C76([BMS Inspections:44])
	For ($vlRecord; 1; $vlWorkingInsps)
		MESSAGE:C88(<>sCR+String:C10($vlRecord)+" of "+String:C10($vlWorkingInsps))
		
		$vdInspDate:=[BMS Inspections:44]Insp Date:4
		$vsBIN:=[BMS Inspections:44]BIN:2
		$vlBMSInspID:=[BMS Inspections:44]Inspection ID:1
		$vsInspType:="PON"
		QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]BMSInspID:3=$vlBMSInspID)
		$vlFound:=Records in selection:C76([Combined Inspections:90])
		If ($vlFound=0)
			//Deal with singlet BMS Inspections
			//Add a Pontis record for a new inspection
			//to hold the BMS Inspection
			CREATE RECORD:C68([Inspections:27])
			//Set default values
			Inc_Sequence("Inspections"; ->[Inspections:27]InspID:2)
			[Inspections:27]BIN:1:=$vsBIN
			[Inspections:27]Insp Type:6:=$vsInspType
			[Inspections:27]Insp Date:78:=$vdInspDate
			[Inspections:27]InspApproved:167:=BMS Approved
			[Inspections:27]InspReviewed:12:=BMS Approved
			[Inspections:27]InspComplete:168:=True:C214
			SAVE RECORD:C53([Inspections:27])
			//Create a Combined Inspection record    
			CREATE RECORD:C68([Combined Inspections:90])
			Inc_Sequence("CombinedInspections"; ->[Combined Inspections:90]ID:6)
			[Combined Inspections:90]BIN:1:=$vsBIN
			[Combined Inspections:90]NBISInspID:2:=[Inspections:27]InspID:2
			[Combined Inspections:90]BMSInspID:3:=$vlBMSInspID
			[Combined Inspections:90]InspDate:4:=$vdInspDate
			[Combined Inspections:90]InspType:5:=$vsInspType
			SAVE RECORD:C53([Combined Inspections:90])
		End if 
		NEXT RECORD:C51([BMS Inspections:44])
	End for 
	CLOSE WINDOW:C154
	If ($err=True:C214)
		ALERT:C41("Multiple Pontis and NBIS Inspections  were found! "+String:C10($vlDupFound)+$vtBadBINS)
	End if 
End if 