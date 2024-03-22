//%attributes = {"invisible":true}
// Method: SIA_BridgeInpNavCTRL
// Description
//  ` Control Navigation in Bridge Input form
// 
// Parameters
// $1 : $PageNumber_L
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/19/10, 08:59:02
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(1/18/11 12:10:44)
	Mods_2011_01
	//  `` Rail Road input changes
	// Modified by: costasmanousakis-(Designer)-(5/2/11 16:40:51)
	Mods_2011_05
	//  `Bug fix for locking after RR input
	Mods_2012_02  //r003
	//Modified by: Charles Miller (2/28/12 15:56:14)
	Mods_2012_03  //r003 `Add code to use list box for Inventory button on 
	//Modified by: Charles Miller (3/29/12 14:11:41)
	// Modified by: Costas Manousakis-(Designer)-(5/3/12 10:34:42)
	Mods_2012_05
	//  `Unload the current record of the table listed
	//  `added the query for [Bridge Design] in here
	// Modified by: Costas Manousakis-(Designer)-(5/10/12 13:48:36)
	Mods_2012_05
	//  `Added vApproveLvl and INSP_KiloPtValues in the call for [Combined Inspections]
	// Modified by: Costas Manousakis-(Designer)-(1/16/13 13:52:24)
	Mods_2013_01
	//  `Added call to ut_Read_Write_Tables ("READ";.. to set  unneeded tables to RO for [Combined Inspections]
	Mods_2013_02  //r001 `  Remove [BridgeInfoLink] updates as we are going to update data on add only
	//Modified by: Charles Miller (2/26/13 16:28:36)
	// Modified by: Costas Manousakis-(Designer)-(3/18/13 14:03:21)
	Mods_2013_03
	//  `Added code to enable MBTAFullEdit users access to Rail Info data
	// Modified by: Costas Manousakis-(Designer)-(4/16/13 11:10:28)
	Mods_2013_04
	//Tunnel inspection
	// Modified by: Costas Manousakis-(Designer)-(6/6/13 10:25:20)
	Mods_2013_06
	//  `in rail road info use new method ut_WindowSize to control window size 
	// Modified by: Costas Manousakis-(Designer)-(2/26/14 13:01:02)
	Mods_2014_02
	//  `Added page 12 - Rating requests
	// Modified by: Costas Manousakis-(Designer)-(3/4/14 12:19:29)
	Mods_2014_03
	//  `removed call to SIA_RRVariableUtil ("LOAD") - called in the form method
	// Modified by: Costas Manousakis-(Designer)-(5/21/14 11:16:14)
	Mods_2014_05
	//  `Enable Add Button for secondary records only in Boston and for InspectionReview Users
	// Modified by: Costas Manousakis-(Designer)-(2/10/17 14:36:08)
	Mods_2017_02
	//  `moved the def of table ptr and form name outside the If ($EditRRInfo_b)  in case =9 or =10
	// Modified by: Costas Manousakis-(Designer)-(5/31/17 16:21:13)
	Mods_2017_05
	//  `for rating reports added code to enable/disable the button the lists available scanned ratings
	Mods_2017_11  //Add code to allow for moving/copying rating reports to directory structure
	//Modified by: Chuck Miller (11/14/17 16:39:12)
	// Modified by: Costas Manousakis-(Designer)-(2/15/19 16:22:05)
	Mods_2019_02_bug
	//  `for Rail/Transit SIA (page=9) use case for insp Resp to account also for DOTRT 
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
	// Modified by: Costas Manousakis-(Designer)-(12/4/19 13:15:09)
	Mods_2019_12
	//  `for ratingreports adjust window size to fit the listbox
	// Modified by: CJMiller-(Designer)-(12/31/19 )
	Mods_2019_12
	//  `Added button and obj method to OpenRatingFolder on page 4 (Rating reports) 
	//  `visible to PersGroup "MoveRatingReports" and Design users
	// Modified by: Costas Manousakis-(Designer)-(3/18/21 19:02:57)
	Mods_2021_03
	//  `added INSP_LoadForApprInspections to the tunnel inspections also
End if 
C_LONGINT:C283($1; $PageNumber_L)
$PageNumber_L:=$1
OBJECT SET VISIBLE:C603(*; "BridgeTemplate_@"; True:C214)
Case of 
	: ($PageNumber_L=2)  //Cons Inspections
		QUERY:C277([Cons Inspection:64]; [Cons Inspection:64]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]InspMonth:34; <)
		If (Not:C34(User in group:C338(<>CurrentUser_Name; "Conslt Rating - ReadWrite")))
			READ ONLY:C145([Cons Inspection:64])
			OBJECT SET ENABLED:C1123(*; "AddConsInspBtn"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"AddConsInspBtn")
		End if 
		UNLOAD RECORD:C212([Cons Inspection:64])
		SIA_ReleaseBridgeRec
		SIA_SetUpListBoxes($PageNumber_L)
		SIA_GoToPage($PageNumber_L)
		
	: ($PageNumber_L=3)  //[Conslt Rating]
		QUERY:C277([Conslt Rating:63]; [Conslt Rating:63]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		ORDER BY:C49([Conslt Rating:63]; [Conslt Rating:63]DateReqbyDistrictBIE:21; <)
		If (Not:C34(User in group:C338(<>CurrentUser_Name; "Conslt Rating - ReadWrite")))
			READ ONLY:C145([Conslt Rating:63])
			OBJECT SET ENABLED:C1123(*; "AddConsRtgBtn"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"AddConsRtgBtn")
		End if 
		UNLOAD RECORD:C212([Conslt Rating:63])
		SIA_ReleaseBridgeRec
		SIA_SetUpListBoxes($PageNumber_L)
		SIA_GoToPage($PageNumber_L)
		
	: ($PageNumber_L=4)  //[RatingReports]
		OBJECT SET VISIBLE:C603(*; "OpenRatingFolder"; False:C215)
		If (GRP_UserInGroup("MoveRatingReports")=1) | (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET VISIBLE:C603(*; "OpenRatingFolder"; True:C214)
		End if 
		vTown:=[Bridge MHD NBIS:1]Town Name:175
		vTown:=vTown+" (D-"+String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))+")"
		If (User in group:C338(<>CurrentUser_Name; "Ratings and Overloads"))
			OBJECT SET ENABLED:C1123(*; "AddRatingBtn"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"AddRatingBtn")
			READ WRITE:C146([RatingReports:65])
			READ WRITE:C146([RatingMember:66])
			
		Else 
			OBJECT SET ENABLED:C1123(*; "AddRatingBtn"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"AddRatingBtn")
			READ ONLY:C145([RatingReports:65])
			READ ONLY:C145([RatingMember:66])
		End if 
		C_TEXT:C284($baseSpec_txt; $ServerToPing_txt)
		$baseSpec_txt:=ut_GetSysParameter("SCRRPT_BaseSpec"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/          RATING REPORTS/Ratings Scanned to Present")
		C_LONGINT:C283($servdelim_L)
		$servdelim_L:=Position:C15("/"; $baseSpec_txt)
		If ($servdelim_L>1)
			$ServerToPing_txt:=Substring:C12($baseSpec_txt; 1; ($servdelim_L-1))
			OBJECT SET VISIBLE:C603(*; "MoveRatingReport@"; False:C215)
			If (SFA_SharedServerAvail($ServerToPing_txt))
				OBJECT SET ENABLED:C1123(*; "ListAvailScanRtgs"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"ListAvailScanRtgs")
			Else 
				OBJECT SET ENABLED:C1123(*; "ListAvailScanRtgs"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"ListAvailScanRtgs")
			End if 
		Else 
			OBJECT SET ENABLED:C1123(*; "ListAvailScanRtgs"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"ListAvailScanRtgs")
		End if 
		//sort rating reports by date decreasing  
		QUERY:C277([RatingReports:65]; [RatingReports:65]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		ORDER BY:C49([RatingReports:65]; [RatingReports:65]ReportDate:4; <; [RatingReports:65]NBIS_Letter_d:36; <; [RatingReports:65]RatingID:21; <)
		UNLOAD RECORD:C212([RatingReports:65])
		SIA_ReleaseBridgeRec
		SIA_SetUpListBoxes($PageNumber_L)
		FORM_FitWindowToCurrPage($PageNumber_L)  //adjust form window size
		SIA_ResetWidths("RatingReports")  // reset the listbox width 
		SIA_GoToPage($PageNumber_L)
		
	: ($PageNumber_L=5)  //[NBIS Secondary]
		QUERY:C277([NBIS Secondary:3]; [NBIS Secondary:3]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		ORDER BY:C49([NBIS Secondary:3]; [NBIS Secondary:3]Item5:4; >)
		UNLOAD RECORD:C212([NBIS Secondary:3])
		SIA_ReleaseBridgeRec
		SIA_SetUpListBoxes($PageNumber_L)
		SIA_GoToPage($PageNumber_L)
		
		If ((User in group:C338(Current user:C182; "Design Access Group")) | (utf_ConnectedToBoston_b & User in group:C338(<>CurrentUser_Name; "InspectionReview")))
			OBJECT SET VISIBLE:C603(*; "AddSecndrBtn"; True:C214)
			OBJECT SET ENABLED:C1123(*; "AddSecndrBtn"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"AddSecndrBtn")
		End if 
		
		READ ONLY:C145([NBIS Secondary:3])
		
	: ($PageNumber_L=6)  //[Bridge Design]
		QUERY:C277([Bridge Design:75]; [Bridge Design:75]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		ORDER BY:C49([Bridge Design:75]; [Bridge Design:75]ADVDate:4; <)
		UNLOAD RECORD:C212([Bridge Design:75])
		If ((User in group:C338(<>CurrentUser_Name; "BridgeDataSheet")) & (Not:C34(User in group:C338(<>CurrentUser_Name; "ReadOnly"))))
			OBJECT SET ENABLED:C1123(*; "AddBrgDesBtn"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"AddBrgDesBtn")
			READ WRITE:C146([Bridge Design:75])
		Else 
			OBJECT SET ENABLED:C1123(*; "AddBrgDesBtn"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"AddBrgDesBtn")
			READ ONLY:C145([Bridge Design:75])
		End if 
		
		SIA_ReleaseBridgeRec
		SIA_SetUpListBoxes($PageNumber_L)
		SIA_GoToPage($PageNumber_L)
		
	: ($PageNumber_L=7)  //[Combined Inspections]
		INSP_LoadForApprInspections
		OBJECT SET VISIBLE:C603(*; "BridgeTemplate_@"; False:C215)
		
		ut_Read_Write_Tables("READ"; ->[Element Cat:32]; ->[ElementDict:30]; ->[Personnel:42]; ->[Inspection Type:31])
		ut_Read_Write_Tables("READ"; ->[Common Notes:54]; ->[BMS Categories:49]; ->[CS Notes:53]; ->[BMS Elements:47])
		ut_Read_Write_Tables("READ"; ->[Cond States:51]; ->[Cat CS Notes:55]; ->[CS Actions:52]; ->[Element Costs:50]; ->[Environments:48])
		
		C_TEXT:C284(INSP_Inspection_list_txt)
		INSP_Inspection_list_txt:="BRIDGE"
		INSP_UpdateInspList
		C_LONGINT:C283(vApproveLvl)  // **replaced _ o _C_INTEGER()
		vApproveLvl:=0  //Cannot approve inspections from this point of entry.
		INSP_KiloPtValues
		SIA_ReleaseBridgeRec
		SIA_SetUpListBoxes($PageNumber_L)
		SIA_GoToPage($PageNumber_L)
		
	: ($PageNumber_L=8)  //[InventoryPhotoInsp]
		SIA_SetUpListBoxes($PageNumber_L)
		INV_GetBINInventoryPhotos
		
		INV_SetHelpMsg_List
		SIA_ReleaseBridgeRec
		SIA_GoToPage($PageNumber_L)
		
	: (($PageNumber_L=9) | ($PageNumber_L=10))  //RailRoad info
		//Can User Edit RR Bridges?
		C_BOOLEAN:C305($EditRRInfo_b)
		C_TEXT:C284($CurrUser_txt)
		$CurrUser_txt:=<>CurrentUser_Name
		$EditRRInfo_b:=(User in group:C338($CurrUser_txt; "RRBridgeEdit") | User in group:C338($CurrUser_txt; "Design Access Group"))
		
		C_LONGINT:C283($WW; $WH)
		ut_WindowSize("GET"; ->$WW; ->$WH)
		
		Case of 
			: (([Bridge MHD NBIS:1]InspResp:173="MBTA") & User in group:C338($currUser_txt; "MBTA_FullEdit"))
				$EditRRInfo_b:=$EditRRInfo_b | True:C214
			: (([Bridge MHD NBIS:1]InspResp:173="DOTRT") & (GRP_UserInGroup("DOTRT_FullEdit")=1))
				$EditRRInfo_b:=$EditRRInfo_b | True:C214
				
		End case 
		
		C_POINTER:C301($TableEdit_ptr)
		C_TEXT:C284($EditForm_txt)
		
		If (False:C215)
			$TableEdit_ptr:=->[RAILBridgeInfo:37]
			$EditForm_txt:="RailInput"
		Else 
			$TableEdit_ptr:=->[Bridge MHD NBIS:1]
			$EditForm_txt:="RAIL_SIA_Input"
		End if 
		
		If ($EditRRInfo_b)
			InitChangeStack(1)  //changes to [Bridge MHD NBIS]
			InitChangeStack(2)  //changes to [RAILBridgeInfo]
			LOAD RECORD:C52([Bridge MHD NBIS:1])
			If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
				
				FORM SET INPUT:C55($TableEdit_ptr->; $EditForm_txt)
				
				SIA_RRVariableUtil("INIT")
				//SIA_RRVariableUtil ("LOAD")
				QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[Bridge MHD NBIS:1]BIN:3)
				
				If (Records in selection:C76([RAILBridgeInfo:37])=1)
					LOAD RECORD:C52([RAILBridgeInfo:37])
					If (ut_LoadRecordInteractive(->[RAILBridgeInfo:37]))
						MODIFY RECORD:C57($TableEdit_ptr->)
					Else 
						ALERT:C41("Could not load for editing the Rail Road Bridge Info!")
						SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
						UNLOAD RECORD:C212([Bridge MHD NBIS:1])
						UNLOAD RECORD:C212([RAILBridgeInfo:37])
						READ ONLY:C145([Bridge MHD NBIS:1])
						READ ONLY:C145([RAILBridgeInfo:37])
						LOAD RECORD:C52([RAILBridgeInfo:37])
						LOAD RECORD:C52([Bridge MHD NBIS:1])
						DIALOG:C40($TableEdit_ptr->; $EditForm_txt)
						
					End if 
					
				Else 
					READ WRITE:C146([RAILBridgeInfo:37])
					ADD RECORD:C56([RAILBridgeInfo:37])
					
				End if 
				
			Else 
				
			End if 
			
		Else 
			SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
			UNLOAD RECORD:C212([Bridge MHD NBIS:1])
			UNLOAD RECORD:C212([RAILBridgeInfo:37])
			READ ONLY:C145([Bridge MHD NBIS:1])
			READ ONLY:C145([RAILBridgeInfo:37])
			LOAD RECORD:C52([Bridge MHD NBIS:1])
			QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[Bridge MHD NBIS:1]BIN:3)
			LOAD RECORD:C52([RAILBridgeInfo:37])
			SIA_RRVariableUtil("INIT")
			//SIA_RRVariableUtil ("LOAD")
			DIALOG:C40($TableEdit_ptr->; $EditForm_txt)
			
		End if 
		SIA_BridgeInput_FM(On Load:K2:1)
		FORM SET INPUT:C55([Bridge MHD NBIS:1]; "Bridge Input")
		
		ut_WindowSize("MATCH"; ->$WW; ->$WH)
		
	: ($PageNumber_L=11)  //tunnel inspections
		INSP_LoadForApprInspections
		OBJECT SET VISIBLE:C603(*; "BridgeTemplate_@"; False:C215)
		
		ut_Read_Write_Tables("READ"; ->[Element Cat:32]; ->[ElementDict:30]; ->[Personnel:42]; ->[Inspection Type:31])
		ut_Read_Write_Tables("READ"; ->[Common Notes:54]; ->[BMS Categories:49]; ->[CS Notes:53]; ->[BMS Elements:47])
		ut_Read_Write_Tables("READ"; ->[Cond States:51]; ->[Cat CS Notes:55]; ->[CS Actions:52]; ->[Element Costs:50]; ->[Environments:48])
		ut_Read_Write_Tables("READ"; ->[TunnelInspection:152]; ->[TunnelInfo:151])
		
		C_TEXT:C284(INSP_Inspection_list_txt)
		INSP_Inspection_list_txt:="TUNNEL"
		INSP_UpdateInspList
		C_LONGINT:C283(vApproveLvl)  // **replaced _ o _C_INTEGER()
		vApproveLvl:=0  //Cannot approve inspections from this point of entry.
		INSP_KiloPtValues
		SIA_ReleaseBridgeRec
		SIA_SetUpListBoxes($PageNumber_L)
		QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		LOAD RECORD:C52([TunnelInfo:151])
		SIA_GoToPage($PageNumber_L)
		
	: ($PageNumber_L=12)  //
		vTown:=[Bridge MHD NBIS:1]Town Name:175
		vTown:=vTown+" (D-"+String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))+")"
		
		If (RtgReq_Edit_b)
			OBJECT SET ENABLED:C1123(*; "AddRatingReqBtn"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"AddRatingReqBtn")
			READ WRITE:C146([RatingRequests:154])
			READ WRITE:C146([AddtlRatingRequests:155])
			
		Else 
			OBJECT SET ENABLED:C1123(*; "AddRatingReqBtn"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"AddRatingReqBtn")
			READ ONLY:C145([RatingRequests:154])
			READ ONLY:C145([AddtlRatingRequests:155])
		End if 
		//sort rating reports by date decreasing  
		QUERY:C277([RatingRequests:154]; [RatingRequests:154]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		ORDER BY:C49([RatingRequests:154]; [RatingRequests:154]DateOfRequest_d:3; <)
		UNLOAD RECORD:C212([RatingRequests:154])
		LB_Tasks("ADDTOLIST"; "RtgReqIncl"; ""; "input")
		SIA_ReleaseBridgeRec
		SIA_SetUpListBoxes($PageNumber_L)
		SIA_GoToPage($PageNumber_L)
End case 