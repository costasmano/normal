//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/13/07, 14:09:29
	// ----------------------------------------------------
	// Method: P_MPA
	// Description
	//Load data for MPA Bridge inspection
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	Mods_2019_07  //Create new list box NewNBIS_StackInfoform to test as width and height changed
	//Modified by: Chuck Miller (7/18/19 12:51:34)
	
End if 
InitProcessVar
C_LONGINT:C283($Width_L; $Height_L)
C_LONGINT:C283($FW; $FL)
FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; DefOutLay; $FW; $FL)

$Width_L:=$FW
$Height_L:=600

MainTitle:="MassPort Inspection"
CurInsp:="MPA"
ModSelSort(->[Bridge MHD NBIS:1]; DefInLay; DefOutLay; MainTitle; $Width_L; $Height_L; 1; 8; ->[Bridge MHD NBIS:1]BDEPT:1; ">"; ->[Bridge MHD NBIS:1]InspResp:173; ->CurInsp)
