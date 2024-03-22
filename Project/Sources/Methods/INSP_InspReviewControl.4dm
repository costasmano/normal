//%attributes = {"invisible":true}
// Method: INSP_InspReviewControl
// Description
//  ` Handle the new Inspectioin Review arrays.
// in table [TableOfLists] the list 
//  ` AreaEngineerGroups has the list of Pers_groups that act as area engineers (2nd level review)
//  ` DBIEGroups has the list of Pers_groups that act as district bridge insp engineers (1st level review)
//  ` INSPTypeRules has the rules for inspection types
//  `  ` param 1 : the owner code
//  `  ` param 2 : inspection type code - can be a wildcard
//  `  ` param 3 : whether a DBIE level review (1st level) is required
//  `  ` param 4 : whether a Area level review (2nd level) is required
//  `  ` param 5 : what is the final level of review (1 or 2)

// Parameters
// $1 : $Task_txt ("INIT" | "CHECK")
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/05/11, 12:13:47
	// ----------------------------------------------------
	
	Mods_2011_10
	// Modified by: costasmanousakis-(Designer)-(10/7/11 09:51:49)
	Mods_2011_10
	//Fixed error in chekc - Final Stage Code section
	// Modified by: costasmanousakis-(Designer)-(10/17/11 16:59:47)
	Mods_2011_10
	//  `Gave all privilegese to Designer group
	// Modified by: costasmanousakis-(Designer)-(10/18/11 10:36:23)
	Mods_2011_10
	//  `Use new global variable ◊CurrentUser_Name
	// Modified by: Costas Manousakis-(Designer)-(5/15/13 10:50:05)
	Mods_2013_05
	//  `Added ◊INSP_@Review_b variables and the following lists in [TableofLists]
	//  `  ` HWYBridgeReview : pers_groups that do hwy bridge review -
	//  `  ` RailBridgeReview : pers_groups that do rail inspection bridge review insp types RR@-
	//  `  ` TunnelReview : pers_groups that do rail inspection bridge review insp types T@-
	// Modified by: Costas Manousakis-(Designer)-(6/7/13 12:01:09)
	Mods_2013_06
	//  `initialize ◊INSP_HWYBrgReview_b  INSP_RailBrgReview_b ◊INSP_TunnelReview_b  to false
End if 

C_TEXT:C284($1; $Task_txt)
If (Count parameters:C259>0)
	$Task_txt:=$1
Else 
	$Task_txt:="INIT"
End if 

C_BOOLEAN:C305($ROstatus_B)
$ROstatus_B:=Read only state:C362([TableOfLists:125])
READ ONLY:C145([TableOfLists:125])

Case of 
	: ($Task_txt="INIT")
		ARRAY TEXT:C222(<>INSP_AreaEngGroups_atxt; 0)
		
		ARRAY TEXT:C222(<>INSP_AreaEngGrpResp_atxt; 0)  //insp responsibilities of area engineers DIST1-6, MBTA, MDC, etc
		
		//load arrays from the tableoflists [TableOfLists]
		C_LONGINT:C283($loop_L)
		ARRAY TEXT:C222($ListValues_atxt; 0)
		QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="AreaEngineerGroups")
		SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $ListValues_atxt)
		
		For ($loop_L; 1; Size of array:C274($ListValues_atxt))
			ARRAY TEXT:C222($parts_atxt; 0)
			ut_TextToArray($ListValues_atxt{$loop_L}; ->$parts_atxt; ";")
			APPEND TO ARRAY:C911(<>INSP_AreaEngGroups_atxt; $parts_atxt{1})
			APPEND TO ARRAY:C911(<>INSP_AreaEngGrpResp_atxt; $parts_atxt{2})
		End for 
		
		ARRAY TEXT:C222(<>INSP_DBIEGroups_atxt; 0)
		ARRAY TEXT:C222(<>INSP_DBIEResp_atxt; 0)  //insp responsibilities of DBIEs DIST1-6, MBTA, MDC, etc
		ARRAY TEXT:C222($ListValues_atxt; 0)
		QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="DBIEGroups")
		SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $ListValues_atxt)
		For ($loop_L; 1; Size of array:C274($ListValues_atxt))
			ARRAY TEXT:C222($parts_atxt; 0)
			ut_TextToArray($ListValues_atxt{$loop_L}; ->$parts_atxt; ";")
			APPEND TO ARRAY:C911(<>INSP_DBIEGroups_atxt; $parts_atxt{1})
			APPEND TO ARRAY:C911(<>INSP_DBIEResp_atxt; $parts_atxt{2})
		End for 
		
		ARRAY TEXT:C222($ListValues_atxt; 0)
		QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="INSPTypeRules")
		SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $ListValues_atxt)
		ARRAY TEXT:C222(<>InspReview_Owner_atxt; 0)
		ARRAY TEXT:C222(<>InspReview_Type_atxt; 0)
		ARRAY TEXT:C222(<>InspReview_DBIEReqd_atxt; 0)
		ARRAY TEXT:C222(<>InspReview_AEReqd_atxt; 0)
		ARRAY TEXT:C222(<>InspReview_FinalStage_atxt; 0)
		
		For ($loop_L; 1; Size of array:C274($ListValues_atxt))
			ARRAY TEXT:C222($parts_atxt; 0)
			ut_TextToArray(Replace string:C233($ListValues_atxt{$loop_L}; " "; ""); ->$parts_atxt; ";")
			APPEND TO ARRAY:C911(<>InspReview_Owner_atxt; $parts_atxt{1})
			APPEND TO ARRAY:C911(<>InspReview_Type_atxt; $parts_atxt{2})
			APPEND TO ARRAY:C911(<>InspReview_DBIEReqd_atxt; $parts_atxt{3})
			APPEND TO ARRAY:C911(<>InspReview_AEReqd_atxt; $parts_atxt{4})
			APPEND TO ARRAY:C911(<>InspReview_FinalStage_atxt; $parts_atxt{5})
			
		End for 
		MULTI SORT ARRAY:C718(<>InspReview_Owner_atxt; >; <>InspReview_Type_atxt; >; <>InspReview_DBIEReqd_atxt; <>InspReview_AEReqd_atxt; <>InspReview_FinalStage_atxt)
		
		//determine responsibilities of current user
		
		C_BOOLEAN:C305(<>INSP_AreaEng_b; <>INSP_DBIE_b; <>INSP_UOEng_b; <>INSP_BridgeInspEng_b; <>INSP_HWYBrgReview_b; <>INSP_RailBrgReview_b; <>INSP_TunnelReview_b)
		<>INSP_AreaEng_b:=False:C215
		<>INSP_DBIE_b:=False:C215
		<>INSP_UOEng_b:=False:C215
		<>INSP_BridgeInspEng_b:=False:C215
		C_LONGINT:C283(<>INSP_MaxApprovalLevel_L)
		<>INSP_MaxApprovalLevel_L:=0
		ARRAY TEXT:C222(<>INSP_MyDistricts_atxt; 0)
		For ($loop_L; 1; Size of array:C274(<>INSP_AreaEngGroups_atxt))
			If (GRP_UserInGroup(<>INSP_AreaEngGroups_atxt{$loop_L}; <>CurrentUser_PID)=1)
				<>INSP_AreaEng_b:=True:C214
				If (<>INSP_MaxApprovalLevel_L<2)
					<>INSP_MaxApprovalLevel_L:=2
				End if 
				If (Find in array:C230(<>INSP_MyDistricts_atxt; <>INSP_AreaEngGrpResp_atxt{$loop_L})<0)
					APPEND TO ARRAY:C911(<>INSP_MyDistricts_atxt; <>INSP_AreaEngGrpResp_atxt{$loop_L})
				End if 
				
			End if 
			
		End for 
		
		For ($loop_L; 1; Size of array:C274(<>INSP_DBIEGroups_atxt))
			If (GRP_UserInGroup(<>INSP_DBIEGroups_atxt{$loop_L}; <>CurrentUser_PID)=1)
				<>INSP_DBIE_b:=True:C214
				If (<>INSP_MaxApprovalLevel_L<1)
					<>INSP_MaxApprovalLevel_L:=1
				End if 
				
				If (Find in array:C230(<>INSP_MyDistricts_atxt; <>INSP_DBIEResp_atxt{$loop_L})<0)
					APPEND TO ARRAY:C911(<>INSP_MyDistricts_atxt; <>INSP_DBIEResp_atxt{$loop_L})
				End if 
				
			End if 
			
		End for 
		
		<>INSP_UOEng_b:=(GRP_UserInGroup("UWInspEngineer"; <>CurrentUser_PID)=1)
		If ((<>INSP_MaxApprovalLevel_L<2) & <>INSP_UOEng_b)
			<>INSP_MaxApprovalLevel_L:=2
		End if 
		
		<>INSP_BridgeInspEng_b:=(GRP_UserInGroup("BridgeInspectionEngineer"; <>CurrentUser_PID)=1)
		If (<>INSP_BridgeInspEng_b)
			ARRAY TEXT:C222(<>INSP_MyDistricts_atxt; 1)
			<>INSP_MyDistricts_atxt{1}:="@"  //all
			If (<>INSP_MaxApprovalLevel_L<2)
				<>INSP_MaxApprovalLevel_L:=2
			End if 
			
		End if 
		
		<>INSP_HWYBrgReview_b:=False:C215
		<>INSP_RailBrgReview_b:=False:C215
		<>INSP_TunnelReview_b:=False:C215
		
		ARRAY TEXT:C222($ListValues_atxt; 0)
		QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="HWYBridgeReview")
		SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $ListValues_atxt)
		For ($loop_L; 1; Size of array:C274($ListValues_atxt))
			If (GRP_UserInGroup($ListValues_atxt{$loop_L}; <>CurrentUser_PID)=1)
				<>INSP_HWYBrgReview_b:=True:C214
			End if 
		End for 
		ARRAY TEXT:C222($ListValues_atxt; 0)
		QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="RailBridgeReview")
		SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $ListValues_atxt)
		For ($loop_L; 1; Size of array:C274($ListValues_atxt))
			If (GRP_UserInGroup($ListValues_atxt{$loop_L}; <>CurrentUser_PID)=1)
				<>INSP_RailBrgReview_b:=True:C214
			End if 
		End for 
		ARRAY TEXT:C222($ListValues_atxt; 0)
		QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="TunnelReview")
		SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $ListValues_atxt)
		For ($loop_L; 1; Size of array:C274($ListValues_atxt))
			If (GRP_UserInGroup($ListValues_atxt{$loop_L}; <>CurrentUser_PID)=1)
				<>INSP_TunnelReview_b:=True:C214
			End if 
		End for 
		
		If (User in group:C338(<>CurrentUser_Name; "Design Access Group"))
			<>INSP_MaxApprovalLevel_L:=2
			<>INSP_UOEng_b:=True:C214
			<>INSP_DBIE_b:=True:C214
			<>INSP_AreaEng_b:=True:C214
			<>INSP_HWYBrgReview_b:=True:C214
			<>INSP_RailBrgReview_b:=True:C214
			<>INSP_TunnelReview_b:=True:C214
		End if 
		
	: ($Task_txt="CHECK")
		//
		//This part verifies whether the data in table of lists  makes sense
		//
		ARRAY TEXT:C222($ListValues_atxt; 0)
		QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="AreaEngineerGroups")
		SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $ListValues_atxt)
		C_TEXT:C284($msg_txt)
		C_LONGINT:C283($recFound_L)
		
		For ($loop_L; 1; Size of array:C274($ListValues_atxt))
			ARRAY TEXT:C222($parts_atxt; 0)
			ut_TextToArray($ListValues_atxt{$loop_L}; ->$parts_atxt; ";")
			//verify that the group exists and the inspection responsibility exist
			SET QUERY DESTINATION:C396(Into variable:K19:4; $recFound_L)
			QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=$parts_atxt{1})
			$msg_txt:="For List AreaEngineerGroups ; item "+String:C10($loop_L)+"["+$ListValues_atxt{$loop_L}+"]"
			If ($recFound_L<=0)
				ALERT:C41($msg_txt+" Group <"+$parts_atxt{1}+"> not found in Groups table!")
			End if 
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173=$parts_atxt{2})
			If ($recFound_L<=0)
				ALERT:C41($msg_txt+" Inspection type <"+$parts_atxt{2}+"> not found in InspType table!")
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
		End for 
		
		ARRAY TEXT:C222($ListValues_atxt; 0)
		QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="DBIEGroups")
		SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $ListValues_atxt)
		For ($loop_L; 1; Size of array:C274($ListValues_atxt))
			ARRAY TEXT:C222($parts_atxt; 0)
			ut_TextToArray($ListValues_atxt{$loop_L}; ->$parts_atxt; ";")
			//verify that the group exists and the inspection responsibility exist
			SET QUERY DESTINATION:C396(Into variable:K19:4; $recFound_L)
			QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=$parts_atxt{1})
			$msg_txt:="For List DBIEGroups ; item "+String:C10($loop_L)+"["+$ListValues_atxt{$loop_L}+"]"
			If ($recFound_L<=0)
				ALERT:C41($msg_txt+" Group <"+$parts_atxt{1}+"> not found in Groups table!")
			End if 
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173=$parts_atxt{2})
			If ($recFound_L<=0)
				ALERT:C41($msg_txt+" Inspection type <"+$parts_atxt{2}+"> not found in InspType table!")
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
		End for 
		
		ARRAY TEXT:C222($ListValues_atxt; 0)
		QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="INSPTypeRules")
		SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $ListValues_atxt)
		ARRAY TEXT:C222(<>InspReview_Owner_atxt; 0)
		ARRAY TEXT:C222(<>InspReview_Type_atxt; 0)
		ARRAY TEXT:C222(<>InspReview_DBIEReqd_atxt; 0)
		ARRAY TEXT:C222(<>InspReview_AEReqd_atxt; 0)
		ARRAY TEXT:C222(<>InspReview_FinalStage_atxt; 0)
		
		For ($loop_L; 1; Size of array:C274($ListValues_atxt))
			ARRAY TEXT:C222($parts_atxt; 0)
			ut_TextToArray(Replace string:C233($ListValues_atxt{$loop_L}; " "; ""); ->$parts_atxt; ";")
			//verify that the owner exists and the inspection type exist, reqd's are Y/N and finalstage is 1 or 2
			
			SET QUERY DESTINATION:C396(Into variable:K19:4; $recFound_L)
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8 Owner:208=$parts_atxt{1})
			$msg_txt:="For List INSPTypeRules ; item "+String:C10($loop_L)+"["+$ListValues_atxt{$loop_L}+"]"
			If ($recFound_L<=0)
				ALERT:C41($msg_txt+" Owner Code <"+$parts_atxt{1}+"> not found in NBI table!")
			End if 
			QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=$parts_atxt{2})
			If ($recFound_L<=0)
				ALERT:C41($msg_txt+" Inspection type <"+$parts_atxt{2}+"> not found in InspType table!")
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If (Position:C15($parts_atxt{3}; "Y;N")<=0)
				ALERT:C41($msg_txt+" DBIE Reqd Code <"+$parts_atxt{3}+"> not Y or N!")
			End if 
			If (Position:C15($parts_atxt{4}; "Y;N")<=0)
				ALERT:C41($msg_txt+" AreaEng Reqd Code <"+$parts_atxt{4}+"> not Y or N!")
			End if 
			If (Position:C15($parts_atxt{5}; "1;2")<=0)
				ALERT:C41($msg_txt+" Final Stage Code <"+$parts_atxt{5}+"> not 1 or 2!")
			End if 
			
		End for 
		
End case 

If (Not:C34($ROstatus_B))
	READ WRITE:C146([TableOfLists:125])
End if 