//%attributes = {"invisible":true}
//Method: TIN_PrintNTIEDReports
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/25/18, 11:27:57
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04
End if 
//
C_LONGINT:C283($Loop_L)

For ($Loop_L; 1; Records in selection:C76([NTI_TunnelInfo:181]))
	
	GOTO SELECTED RECORD:C245([NTI_TunnelInfo:181]; $Loop_L)
	If ($Loop_L=1)
		PRINT SETTINGS:C106
		OPEN PRINTING JOB:C995
	End if 
	Print form:C5([NTI_TunnelInfo:181]; "NTIED_Print")
End for 
CLOSE PRINTING JOB:C996
//End TIN_PrintNTIEDReports