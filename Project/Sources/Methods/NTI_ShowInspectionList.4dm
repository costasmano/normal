//%attributes = {"invisible":true}
//Method: NTI_ShowInspectionList
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/26/16, 10:43:31
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
C_LONGINT:C283($Width_L; $Height_L; $Choice_L)
FORM GET PROPERTIES:C674([NTI_TunnelInfo:181]; "InspectionList"; $Width_L; $Height_L)

UNLOAD RECORD:C212([NTI_TunnelInfo:181])
ut_SetReadWrite("read"; ->[NTI_TunnelInfo:181])
LOAD RECORD:C52([NTI_TunnelInfo:181])
NTI_INIT
DIALOG:C40([NTI_TunnelInfo:181]; "InspectionList")

//End NTI_ShowInspectionList