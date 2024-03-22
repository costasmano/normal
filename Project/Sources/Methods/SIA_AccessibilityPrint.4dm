//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/28/07, 08:49:35
	// ----------------------------------------------------
	// Method: SIA_AccessibilityPrint
	// Description
	// Calc the accessibility variables used in SIA print forms
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
End if 
C_TEXT:C284(sLift; sLadder; sBoat; sWader; sInsp50; sRigging; sStaging; sTraffic; sRR; sPolice; sAccOth)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(sLiftU; sLadderU; sBoatU; sWaderU; sInsp50U; sRiggingU; sStagingU; sTrafficU; sRRU; sPoliceU; sAccOthU)  // Command Replaced was o_C_STRING length was 1

sLift:=Substring:C12([Bridge MHD NBIS:1]LiftBucket:30; 1; 1)
sLiftU:=Substring:C12([Bridge MHD NBIS:1]LiftBucket:30; 2; 1)
sLadder:=Substring:C12([Bridge MHD NBIS:1]Ladder:31; 1; 1)
sLadderU:=Substring:C12([Bridge MHD NBIS:1]Ladder:31; 2; 1)
sBoat:=Substring:C12([Bridge MHD NBIS:1]Boat:32; 1; 1)
sBoatU:=Substring:C12([Bridge MHD NBIS:1]Boat:32; 2; 1)
sWader:=Substring:C12([Bridge MHD NBIS:1]Wader:33; 1; 1)
sWaderU:=Substring:C12([Bridge MHD NBIS:1]Wader:33; 2; 1)
sInsp50:=Substring:C12([Bridge MHD NBIS:1]Inspector50:34; 1; 1)
sInsp50U:=Substring:C12([Bridge MHD NBIS:1]Inspector50:34; 2; 1)
sRigging:=Substring:C12([Bridge MHD NBIS:1]Rigging:35; 1; 1)
sRiggingU:=Substring:C12([Bridge MHD NBIS:1]Rigging:35; 2; 1)
sStaging:=Substring:C12([Bridge MHD NBIS:1]Staging:36; 1; 1)
sStagingU:=Substring:C12([Bridge MHD NBIS:1]Staging:36; 2; 1)
sTraffic:=Substring:C12([Bridge MHD NBIS:1]Traffic Control:37; 1; 1)
sTrafficU:=Substring:C12([Bridge MHD NBIS:1]Traffic Control:37; 2; 1)
sRR:=Substring:C12([Bridge MHD NBIS:1]RR Flagman:38; 1; 1)
sRRU:=Substring:C12([Bridge MHD NBIS:1]RR Flagman:38; 2; 1)
sPolice:=Substring:C12([Bridge MHD NBIS:1]Police:39; 1; 1)
sPoliceU:=Substring:C12([Bridge MHD NBIS:1]Police:39; 2; 1)
sAccOth:=Substring:C12([Bridge MHD NBIS:1]OtherAccBool:181; 1; 1)
sAccOthU:=Substring:C12([Bridge MHD NBIS:1]OtherAccBool:181; 2; 1)