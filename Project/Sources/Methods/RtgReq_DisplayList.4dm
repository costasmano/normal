//%attributes = {"invisible":true}
//Method: RtgReq_DisplayList
//Description
//  ` display the list of all rating requests
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 11:35:44
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 11:02:34)
	Mods_2021_10
	//  `made stack size of new process 0
End if 
//
If (Count parameters:C259=0)
	C_LONGINT:C283($ProcessID_l)
	
	$ProcessID_l:=LProcessID("Rating Requests")
	If ($ProcessID_l=-1)
		$ProcessID_l:=New process:C317("RtgReq_DisplayList"; 0; "Rating Requests"; "Run")
	Else 
		POST OUTSIDE CALL:C329($ProcessID_l)
		SHOW PROCESS:C325($ProcessID_l)
		BRING TO FRONT:C326($ProcessID_l)
	End if 
	
Else 
	C_TEXT:C284($1)
	InitProcessVar
	InitPers
	
	C_LONGINT:C283($Width; $Height; $Win_L)
	FORM GET PROPERTIES:C674([RatingRequests:154]; "Output"; $Width; $Height)
	$Win_L:=ut_OpenNewWindow($Width; $Height; 2; 0; ""; "ut_CloseCancel")
	UpdatWindArray(""; Current process:C322)
	
	DIALOG:C40([RatingRequests:154]; "Output")
	
	CLOSE WINDOW:C154
	UpdatWindArray(""; Current process:C322; True:C214)
	
End if 

//End RtgReq_DisplayList