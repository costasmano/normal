//SC vAgency on layout [BMS Inspections];"Inspections In".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Display variable for the Inspecting Agency.

//TRACE

C_TEXT:C284(vAgency)  // Command Replaced was o_C_STRING length was 30

If (Form event code:C388=On Load:K2:1)
	//Set up the display variable.
	If ([BMS Inspections:44]Agency:13="")
		vAgency:="Select Insp. Agency"
	Else 
		vAgency:=[BMS Inspections:44]Agency:13
	End if 
	
	//Set up the team leader and team member arrays.
	InitPers([BMS Inspections:44]Agency:13)
	
	//InitPers recreates the Team Leader array; reset it.  
	aTeamLeader:=Find in array:C230(aTeamLdrID; [BMS Inspections:44]TeamLeader:6)
	If (aTeamLeader<=0)  //Just in case nothing was found in array
		aTeamLeader:=0
	End if 
End if 