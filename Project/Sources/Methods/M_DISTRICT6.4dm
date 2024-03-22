//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/22/10, 11:41:37
	// ----------------------------------------------------
	// Method: Method: M_DISTRICT6
	// Description
	// Added to display the future District 6 bridges
	// 
	// Parameters
	// $1 : $Task (Optional)
	// When no task, will launch a process for itself, with a parameter to skip the relaunching
	// ----------------------------------------------------
	
	Mods_2010_02
	// Modified by: costasmanousakis-(Designer)-(3/3/10 07:51:06)
	Mods_2010_03
	//  `Added declaration of $1. would fail in compiled mode.
	// Modified by: costasmanousakis-(Designer)-(8/5/10 12:25:29)
	Mods_2010_08
	//  `Chnaged window title to remove the "Future" word
	// Modified by: costasmanousakis-(Designer)-(1/5/11 09:44:55)
	Mods_2011_01
	//  `Adjusted selection of bridges
	Mods_2011_03  //Change width of form from 620 to 830
	Mods_2019_09  //Create method to handle resize of windows between out and input forms
	//Modified by: Chuck Miller (9/26/19 14:51:05)
	// Modified by: Costas Manousakis-(Designer)-(3/31/20 12:05:23)
	Mods_2020_03
	//  `removed old code used while transitioning from MTA etc. Now use same code as in the P_Districtx methods
End if 
If (Count parameters:C259=0)
	C_LONGINT:C283($LPid_L)
	$LPid_L:=LSpawnProcess("M_DISTRICT6"; <>LStackSize; "District 6"; True:C214; False:C215; "RUN")
Else 
	
	InitProcessVar
	C_LONGINT:C283($Width_L; $Height_L)
	C_LONGINT:C283($FW; $FL)
	FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; DefOutLay; $FW; $FL)
	
	$Width_L:=$FW
	$Height_L:=600
	
	MainTitle:="District 6 Inspection"
	CurInsp:="DIST6"
	ModSelSort(->[Bridge MHD NBIS:1]; DefInLay; DefOutLay; MainTitle; $Width_L; $Height_L; 1; 8; ->[Bridge MHD NBIS:1]BDEPT:1; ">"; ->[Bridge MHD NBIS:1]InspResp:173; ->CurInsp)
	
End if 