//SC aAgency on layout [BMS Inspections];"Inspections In".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Pop up menu for the inspecting agency.

//TRACE
If (False:C215)
	Mods_2017_08  //replace _ o _during
End if 
C_BOOLEAN:C305($reset)

REDRAW:C174(aAgency)
If ((Form event code:C388=On Clicked:K2:4) & (aAgency>0))  //replace _ o _during
	$reset:=True:C214
Else 
	$reset:=False:C215
End if 
POPUPMENUC(->aAgency; ->aAgency; ->[BMS Inspections:44]Agency:13)
If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([BMS Inspections:44]Agency:13)#[BMS Inspections:44]Agency:13)
		PushChange(1; ->[BMS Inspections:44]Agency:13)
	End if 
End if 
If ($reset)
	vAgency:=aAgency{aAgency}
	
	//Set up the team leader and team member arrays.
	REDRAW:C174(aTeamLeader)
	InitPers(vAgency)
	//InitPers recreates the Team Leader array; reset it.  
	aTeamLeader:=Find in array:C230(aTeamLdrID; [BMS Inspections:44]TeamLeader:6)
	If (aTeamLeader<=0)  //Just in case nothing was found in array
		aTeamLeader:=0
	End if 
	If ([BMS Inspections:44]TeamLeader:6=0)
		If (Size of array:C274(aTeamLeader)=0)
			vTmLeader:="No leaders on file."
		Else 
			vTmLeader:="Select Team Leader"
		End if 
	End if 
End if 