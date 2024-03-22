//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/06/06, 09:32:56
	// ----------------------------------------------------
	// Method: INSP_TeamLeader_OM
	// Description
	// Object method for TeamLeader pulldown in Inspection forms
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy2
	// Modified by: Costas Manousakis-(Designer)-(4/10/14 16:37:26)
	Mods_2014_04
	//  `removed check for app version (◊LNK_CHANGE_Vers ) - use LogLink for all cases
End if 

REDRAW:C174(aTeamLeader)
POPUPMENUC(->aTeamLeader; ->aTeamLdrID; ->[Inspections:27]TeamLeader:4)
If (Form event code:C388=On Clicked:K2:4)
	If (aTeamLeader>0)
		vTmLeader:=aTeamLeader{aTeamLeader}
	End if 
	LogLink(->[Inspections:27]TeamLeader:4; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
	PushChange(1; ->[Inspections:27]DateModified:137)
	If ([BMS Inspections:44]Inspection ID:1>0)
		[BMS Inspections:44]TeamLeader:6:=[Inspections:27]TeamLeader:4
		LogLink(->[BMS Inspections:44]TeamLeader:6; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
		PushChange(3; ->[BMS Inspections:44]DateModified:10)
		SAVE RECORD:C53([BMS Inspections:44])
	End if 
	
End if 