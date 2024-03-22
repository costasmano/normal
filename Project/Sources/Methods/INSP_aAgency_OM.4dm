//%attributes = {"invisible":true}
//Method: INSP_aAgency_OM
//Description
//  ` Object method for Agency pulldown in Inspection forms
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/07/13, 10:10:41
	// ----------------------------------------------------
	//Created : 
	Mods_2013_01
End if 
//
C_BOOLEAN:C305($reset)

REDRAW:C174(aAgency)
If ((Form event code:C388=On Clicked:K2:4) & (aAgency>0))
	$reset:=True:C214
Else 
	$reset:=False:C215
End if 
POPUPMENUC(->aAgency; ->aAgency; ->[Inspections:27]Agency:156)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Inspections:27]Agency:156)
	If (Is record loaded:C669([BMS Inspections:44]))
		[BMS Inspections:44]Agency:13:=[Inspections:27]Agency:156
		PushChange(3; ->[BMS Inspections:44]Agency:13)
		SAVE RECORD:C53([BMS Inspections:44])
	End if 
	
End if 
If ($reset)
	vAgency:=aAgency{aAgency}
	
	//Set up the team leader and team member arrays.
	REDRAW:C174(aTeamLeader)
	InitPers(vAgency)
	//InitPers recreates the Team Leader array; reset it.  
	aTeamLeader:=Find in array:C230(aTeamLdrID; [Inspections:27]TeamLeader:4)
	If (aTeamLeader<=0)  //Just in case nothing was found in array
		aTeamLeader:=0
	End if 
	If ([Inspections:27]TeamLeader:4=0)
		If (Size of array:C274(aTeamLeader)=0)
			vTmLeader:="No leaders on file."
		Else 
			vTmLeader:="Select Team Leader"
		End if 
	End if 
End if 
//End INSP_aAgency_OM