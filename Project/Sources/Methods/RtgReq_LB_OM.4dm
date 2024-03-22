//%attributes = {"invisible":true}
// Method: RtgReq_LB_OM
// Description
//  ` method for the rating requests list box in the output form
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 11:45:01
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can not double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/17/17 13:40:53)
	// Modified by: Costas Manousakis-(Designer)-(3/31/21 19:02:22)
	Mods_2021_03
	//  `initialize the InDoubleClick_B var on load event
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 10:56:41)
	Mods_2021_10
	//  `unload record after sorting
End if 
//
C_LONGINT:C283($0)
$0:=0

C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Display Detail:K2:22)
		
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[RatingRequests:154]BIN:1)
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		//COPY NAMED SELECTION([RatingRequests];"LBSELECTIONRTGREQ")
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			If (RtgReq_Edit_b)
				READ WRITE:C146([RatingRequests:154])
				READ WRITE:C146([AddtlRatingRequests:155])
			End if 
			LB_Tasks("DOUBLECLICK"; "RtgReq")
			//If (LB_Tasks ("DOUBLECLICK";"RtgReq")=1)
			//  `what happens if you delete something???????
			//  `USE NAMED SELECTION("LBSELECTIONRTGREQ")
			//  `CLEAR NAMED SELECTION("LBSELECTIONRTGREQ")
			REDRAW:C174(RtgReq_LB)
			//End if 
			READ ONLY:C145([RatingRequests:154])
			READ ONLY:C145([AddtlRatingRequests:155])
			UNLOAD RECORD:C212([RatingRequests:154])
			UNLOAD RECORD:C212([AddtlRatingRequests:155])
			InDoubleClick_B:=False:C215
		End if 
		
		
	: ($FormEvent_L=On Clicked:K2:4)
		
		C_LONGINT:C283($LBCol_L; $LBRow_L; $SelectedRow_L; $Ret_L; $MinRet_L; $MaxRet_L)
		LISTBOX GET CELL POSITION:C971(*; "RtgReq_LB"; $LBCol_L; $LBRow_L)
		
		C_LONGINT:C283($Popupchoice_L)
		C_TEXT:C284($Popupmenu_txt)
		If ((Right click:C712) | (Macintosh control down:C544))
			$Popupchoice_L:=Pop up menu:C542($Popupmenu_txt)
			
			Case of 
				: ($Popupchoice_L=1)
					
			End case 
			
		End if 
		
	: ($FormEvent_L=On Load:K2:1)
		C_BOOLEAN:C305(InDoubleClick_B)
		InDoubleClick_B:=False:C215
	: ($FormEvent_L=On After Sort:K2:28)
		UNLOAD RECORD:C212([RatingRequests:154])
		
	: ($FormEvent_L=On Header Click:K2:40)
		
		C_TEXT:C284($NameofObj_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
		//ALERT("Click on header "+$nameofObj_txt)
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		Case of 
			: ($nameofObj_txt="Header10")  //Dist
				If ((Self:C308->=2) | (Self:C308->=0))
					//ORDER BY FORMULA([RatingRequests];RtgReq_GetBridgeInfo ([RatingRequests]BIN;->[Bridge MHD NBIS]Item2);>)
					ORDER BY:C49([RatingRequests:154]; [Bridge MHD NBIS:1]Item2:60; >)
					Self:C308->:=1
				Else 
					//ORDER BY FORMULA([RatingRequests];RtgReq_GetBridgeInfo ([RatingRequests]BIN;->[Bridge MHD NBIS]Item2);<)
					ORDER BY:C49([RatingRequests:154]; [Bridge MHD NBIS:1]Item2:60; <)
					Self:C308->:=2
					
				End if 
				$0:=-1
			: ($nameofObj_txt="Header2")  //BDEPT
				If ((Self:C308->=2) | (Self:C308->=0))
					//ORDER BY FORMULA([RatingRequests];RtgReq_GetBridgeInfo ([RatingRequests]BIN;->[Bridge MHD NBIS]BDEPT);>)
					ORDER BY:C49([RatingRequests:154]; [Bridge MHD NBIS:1]BDEPT:1; >)
					Self:C308->:=1
				Else 
					//ORDER BY FORMULA([RatingRequests];RtgReq_GetBridgeInfo ([RatingRequests]BIN;->[Bridge MHD NBIS]BDEPT);<)
					ORDER BY:C49([RatingRequests:154]; [Bridge MHD NBIS:1]BDEPT:1; <)
					Self:C308->:=2
				End if 
				$0:=-1
			: ($nameofObj_txt="Header4")  //Priority
				If ((Self:C308->=2) | (Self:C308->=0))
					ORDER BY FORMULA:C300([RatingRequests:154]; RtgReq_SortByPriority; >)
					Self:C308->:=1
				Else 
					ORDER BY FORMULA:C300([RatingRequests:154]; RtgReq_SortByPriority; <)
					Self:C308->:=2
				End if 
				$0:=-1
				
		End case 
		UNLOAD RECORD:C212([RatingRequests:154])
		
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
End case 
//End RtgReq_LB_OM