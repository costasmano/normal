If (False:C215)
	//procedure: ZZ5 on [Standard Photos];"Standard Photos"
	//created: 4/30/2001
	//purpose: log the deletion of an Inspection Image record
	//modified: 
	// Dec/2001: re-sequence other records and refresh the selection 
	//parameters:
	//Comments : Button MUST be set to 'No Action'
	
	// Modified by: costasmanousakis-(Designer)-(10/20/2005 11:33:48)
	Mods_2005_CM17
End if 

C_TEXT:C284($Text)  //Alert message text.

//ask for confirmation..
$Text:="Do you really want to delete this Image?"
CONFIRM:C162($Text)
If (OK=1)
	If (Is new record:C668([Standard Photos:36]))
		CANCEL:C270  //just cancel if a new image
	Else 
		C_LONGINT:C283($newv; $nphotos; $currID; $i)
		C_TEXT:C284($CurrType)  // Command Replaced was o_C_STRING length was 2
		
		$newv:=[Standard Photos:36]SeqNum:6
		$currID:=[Standard Photos:36]StdPhotoID:7
		$currType:=[Standard Photos:36]PictType:5
		//Nov -02 : added a check to see where we are deleting from
		//Avoid doing any resets when in "user mode"
		C_TEXT:C284($pname)  // Command Replaced was o_C_STRING length was 132
		C_LONGINT:C283($pstate; $ptime)
		LogDeletion(->[Inspections:27]InspID:2; ->[Standard Photos:36]InspID:1; ->[Standard Photos:36]StdPhotoID:7; 2)
		DELETE RECORD:C58([Standard Photos:36])
		
		//Avoid doing any resets when in "user mode"
		PROCESS PROPERTIES:C336(Current process:C322; $pname; $pstate; $ptime)
		If ($pname#"User/Custom Menus process")
			QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2)
			G_ResortImages(-1; $currID; $CurrType)
			Case of 
				: ($currType=BMS Photo)
					vNextPhotoSeq:=vNextPhotoSeq-1
				: ($currType=BMS Sketch)
					vNextSketchSeq:=vNextSketchSeq-1
				: ($currType=BMS Chart)
					vNextChartSeq:=vNextChartSeq-1
			End case 
		End if 
		
		CANCEL:C270
	End if   //if not user process
End if 