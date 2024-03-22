//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/15/09, 13:45:01
	// ----------------------------------------------------
	// Method: SCPOA_PostFloodChecks
	// Description
	//  `Manage the chekboxes in the Post Flood Monitoring program
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_12
	
	// Modified by: Costas Manousakis-(Designer)-(2/29/12 21:48:38)
	Mods_2012_02
	//  `Changes for the new version of POA
	
End if 
C_LONGINT:C283($check_L)

$check_L:=SCPOA_PostFldVis_L+SCPOA_PostFldRvBed_L+SCPOA_PostFldProfSubstr_L+SCPOA_PostFldUnderm_L+SCPOA_PostFldUWInsp_L+SCPOA_PostFldProbing_L
If ($check_L>0)
	SCPOA_PostFlood_L:=1
Else 
	SCPOA_PostFlood_L:=0
End if 