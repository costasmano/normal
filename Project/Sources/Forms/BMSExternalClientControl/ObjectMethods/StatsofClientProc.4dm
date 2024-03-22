//Method: BMSExternalClientControl.StopClientControlProcess
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/11/20, 11:53:03
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
End if 
//
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($Lpid_L)
		$Lpid_L:=LProcessID("Control Client Process")
		If ($Lpid_L>0)
			C_TEXT:C284($procName)
			C_LONGINT:C283($procState; $uniqueID; $origin; $procTime)
			C_BOOLEAN:C305($Vis_b)
			PROCESS PROPERTIES:C336($Lpid_L; $procName; $procState; $procTime; $Vis_b; $uniqueID; $origin)
			ALERT:C41("Process ID "+String:C10($Lpid_L)+\
				"\rName \""+$procName+"\""+\
				"\rState "+String:C10($procState)+":"+Dev_procStatus($procState)+\
				"\rTime "+String:C10($procTime)+\
				"\rVisible "+Choose:C955($Vis_b; "Yes"; "No")+\
				"\rUnique ID "+String:C10($uniqueID)+\
				"\rOrigin "+String:C10($origin)+":"+Dev_ProcOrigin($origin))
		Else 
			ALERT:C41("No Process found called <Control Client Process>")
		End if 
End case 

//End BMSExternalClientControl.StopClientControlProcess