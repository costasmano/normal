//%attributes = {"invisible":true}
//Method: NTI_ListPendingTINInsp
//Description
// List the pending TIN Inspections
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/09/16, 15:29:45
	// ----------------------------------------------------
	//Created : 
	Mods_2016_09
	C_TEXT:C284(NTI_ListPendingTINInsp; $1)
	// Modified by: Costas Manousakis-(Designer)-(2/2/17 17:09:37)
	Mods_2017_02
	//  `use new method NTI_GetMyPending
	Mods_2018_12_bug
	//  `The sort is done in NTI_GetMyPending
End if 
//

If (Count parameters:C259=0)
	//Launch me a new proces
	C_LONGINT:C283($LPid)
	$LPid:=LSpawnProcess("NTI_ListPendingTINInsp"; <>LStackSize; "Pending TIN Insp"; True:C214; False:C215; "RUN")
Else 
	//run me
	C_TEXT:C284($1)
	C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
	
	C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
	vsForward:=<>Forward
	READ ONLY:C145(*)
	
	SHORT_MESSAGE("Retrieving data. Please wait…")
	Compiler_LB
	Compiler_NTI
	InitPers
	InitProcessVar
	NTI_FillDropDowns
	NTI_SetUpPermissions
	NTI_LoadDOMTrees
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
	
	//QUERY([TIN_Inspections];[TIN_Inspections]InspApproval#BMS Approved )
	NTI_GetMyPending
	COPY NAMED SELECTION:C331([TIN_Inspections:184]; "NTI_PendInspList")
	C_LONGINT:C283($Width_L; $Height_L)
	SET MENU BAR:C67("Blankmenu")
	UpdatWindArray(""; Current process:C322)
	
	CLOSE WINDOW:C154
	
	FORM GET PROPERTIES:C674([TIN_Inspections:184]; "ReviewList"; $Width_L; $Height_L)
	ut_OpenNewWindow($Width_L; 700; 2; Plain window:K34:13)
	DIALOG:C40([TIN_Inspections:184]; "ReviewList")
	CLEAR NAMED SELECTION:C333("NTI_PendInspList")
	
	UpdatWindArray(""; Current process:C322)
	
End if 


//End NTI_ListPendingTINInsp