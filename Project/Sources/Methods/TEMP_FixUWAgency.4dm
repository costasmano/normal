//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/02/08, 16:18:23
	// ----------------------------------------------------
	// Method: TEMP_FixUWAgency
	// Description
	// Fix the missing UW agency in DV@ inspections
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
End if 
If (Current user:C182="Designer")
	QUERY:C277([Inspections:27]; [Inspections:27]Insp Type:6="DV@")
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Agency:156="")
	C_LONGINT:C283($numblanks; $i)
	$numblanks:=Records in selection:C76([Inspections:27])
	CONFIRM:C162("Found "+String:C10($numblanks)+" dive inspections with blank agency. Set to MHDUW?"; "SET"; "Cancel")
	If (OK=1)
		SHORT_MESSAGE("Updating UW agency..")
		FIRST RECORD:C50([Inspections:27])
		$i:=0
		While (Not:C34(End selection:C36([Inspections:27])))
			$i:=$i+1
			MESSAGE:C88(","+String:C10($i))
			If (ut_LoadRecordInteractive(->[Inspections:27]))
				[Inspections:27]Agency:156:="MHD Underwater Oper."
				LogChanges(->[Inspections:27]Agency:156; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
				SAVE RECORD:C53([Inspections:27])
			End if 
			NEXT RECORD:C51([Inspections:27])
		End while 
		
		CLOSE WINDOW:C154
	End if 
	
End if 