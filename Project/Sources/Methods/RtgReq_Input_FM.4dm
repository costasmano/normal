//%attributes = {"invisible":true}
// Method: RtgReq_Input_FM
// Description
//  ` Method for input form for Rating Requests
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 11:41:15
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
	// Modified by: Costas Manousakis-(Designer)-(4/24/14 10:35:02)
	Mods_2014_04_bug
	//  `  `make sure correct bridge record is loaded RO
	// Modified by: Costas Manousakis-(Designer)-(4/30/14 14:42:15)
	Mods_2014_04_bug
	//  `Move the lognewrecord in the save button. At the On Validate event the record is not new anymore
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/21/17 15:07:37)
End if 
//
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		C_LONGINT:C283($CurrL_L; $CurrT_L; $CurrR_L; $CurrB_L; $FormW_L; $FormH_L; $CurrW_L; $CurrH_L)
		GET WINDOW RECT:C443($CurrL_L; $CurrT_L; $CurrR_L; $CurrB_L)
		$CurrW_L:=$CurrR_L-$CurrL_L
		$CurrH_L:=$CurrB_L-$CurrT_L
		FORM GET PROPERTIES:C674([RatingRequests:154]; "Input"; $FormW_L; $FormH_L)
		C_BOOLEAN:C305($Resize_b)
		$Resize_b:=($CurrW_L<$FormW_L) | ($CurrH_L<$FormH_L)
		If ($Resize_b)
			If ($CurrW_L<$FormW_L)
				$CurrR_L:=$FormW_L-$CurrW_L
			Else 
				$CurrR_L:=0
			End if 
			If ($CurrH_L<$FormH_L)
				$CurrB_L:=$FormH_L-$CurrH_L
			Else 
				$CurrB_L:=0
			End if 
			RESIZE FORM WINDOW:C890($CurrR_L; $CurrB_L)
		End if 
		
		If (Is new record:C668([RatingRequests:154]))
			[RatingRequests:154]BIN:1:=[Bridge MHD NBIS:1]BIN:3
			Inc_Sequence("RatingRequest"; ->[RatingRequests:154]RatingRequestID_L:2)
			[RatingRequests:154]DateOfRequest_d:3:=Current date:C33(*)
		End if 
		InitChangeStack(1)  //request
		InitChangeStack(2)  //Addtional
		//make sure correct bridge record is loaded RO
		
		If ([Bridge MHD NBIS:1]BIN:3=[RatingRequests:154]BIN:1)
		Else 
			If (Not:C34(Read only state:C362([Bridge MHD NBIS:1])))
				READ ONLY:C145([Bridge MHD NBIS:1])
			End if 
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[RatingRequests:154]BIN:1)
			LOAD RECORD:C52([Bridge MHD NBIS:1])
		End if 
		
		QUERY:C277([AddtlRatingRequests:155]; [AddtlRatingRequests:155]RatingRequestID_L:1=[RatingRequests:154]RatingRequestID_L:2)
		ORDER BY:C49([AddtlRatingRequests:155]; [AddtlRatingRequests:155]NewRequestDate_d:3; <)
		//start the lb for the addtl requests
		LB_Tasks("ADDTOLIST"; "AddtlReq"; ""; "Input")
		RtgReq_Utility("LOADCBARRAYS")
		RtgReq_Utility("LOADCONTRACTS")
		RtgReq_Contracts_cb{0}:=[RatingRequests:154]ContractNo_L:17
		RtgReq_Utility("LOADASSIGNMENTS")
		RtgReq_ContrAssign_cb{0}:=[RatingRequests:154]AssignmentNo_L:18
		
		If (Read only state:C362([RatingRequests:154]))
			OBJECT SET ENABLED:C1123(*; "DE @"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(*; "DE @"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		InDoubleClick_B:=False:C215
	: ($FormEvent_L=On Validate:K2:3)
		
		PushAllChanges(1; ->[RatingRequests:154]; ->[RatingRequests:154]BIN:1; ->[RatingRequests:154]RatingRequestID_L:2)
		FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[RatingRequests:154]BIN:1; ->[RatingRequests:154]RatingRequestID_L:2; 1)
		
	: ($FormEvent_L=On Unload:K2:2)
		
End case 

//End RtgReq_Input_FM