// ----------------------------------------------------
// Form Method: ProjectTimeTracking.i
// User name (OS): cjmiller
// Date and time: 01/04/07, 16:54:32
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_TimeTracking
	Mods_2006_CJMv2  //03/15/07, 12:49:34`Make array names uniform
	Mods_2007_CJMv2  //r060   `05/16/07, 15:16:06 `Add code to control access 
	// Modified by: costasmanousakis-(Designer)-(10/8/08 15:57:26)
	Mods_2008_CM_5404  // ("ACCESS")
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		ut_SetStringOrTextFilter(->[PRJ_ProjectTimeTracking:124]PT_Coments_txt:5)
		ut_SetStringOrTextFilter(->[PRJ_ProjectTimeTracking:124]PT_EWO_s:8)
		
		PRJ_PT_GetConsRevLists
		OBJECT SET ENABLED:C1123(bValidate; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(bDelete; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		C_LONGINT:C283($Color_l)
		$Color_l:=0
		OBJECT SET ENTERABLE:C238(PRJ_ConsultantReviewers_atxt; True:C214)
		OBJECT SET ENTERABLE:C238(PT_ListofEWOs_atxt; True:C214)
		ARRAY TEXT:C222(PT_ListofEWOs_atxt; 4)
		PT_ListofEWOs_atxt{1}:="Local Design EWO :"
		PT_ListofEWOs_atxt{2}:="Project Design EWO :"+[PRJ_ProjectFile:117]PF_EWO_s:4
		PT_ListofEWOs_atxt{3}:="Local Constr EWO :"+[PRJ_ProjectDetails:115]PRJ_EnteredConstructionEWO_s:31
		PT_ListofEWOs_atxt{4}:="Project Constr EWO :"+[PRJ_ConstructionProject:116]CP_EWO_s:9
		ARRAY TEXT:C222(PT_ListofEWOs_as; 4)  //Command Replaced was o_ARRAY string length was 21
		PT_ListofEWOs_as{1}:=""
		PT_ListofEWOs_as{2}:="022"+[PRJ_ProjectFile:117]PF_EWO_s:4
		PT_ListofEWOs_as{3}:=[PRJ_ProjectDetails:115]PRJ_EnteredConstructionEWO_s:31
		PT_ListofEWOs_as{4}:="022"+[PRJ_ConstructionProject:116]CP_EWO_s:9
		If (Is new record:C668(Current form table:C627->))
			If (PRJ_MembershipGroup_txt="PRJ_CreateGroup") | (PRJ_MembershipGroup_txt="PRJ_Tool")
				
				C_TEXT:C284($ChosenEWO_s)  // Command Replaced was o_C_STRING length was 21
				[PRJ_ProjectTimeTracking:124]PT_WeekEnding_d:4:=Add to date:C393(Current date:C33(*); 0; 0; (7-Day number:C114(Current date:C33(*))))
				Inc_Sequence("PRJ_TimeSheetEntry"; ->[PRJ_ProjectTimeTracking:124]PT_TimeTrackingID_l:1)
				[PRJ_ProjectTimeTracking:124]PRJ_ProjectID_l:2:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
				Case of 
					: ([PRJ_ProjectFile:117]PF_EWO_s:4#"")
						$ChosenEWO_s:="022"+[PRJ_ProjectFile:117]PF_EWO_s:4
					: ([PRJ_ProjectDetails:115]PRJ_EnteredConstructionEWO_s:31#"")
						$ChosenEWO_s:=[PRJ_ProjectDetails:115]PRJ_EnteredConstructionEWO_s:31
					: ([PRJ_ConstructionProject:116]CP_EWO_s:9#"")
						$ChosenEWO_s:="022"+[PRJ_ConstructionProject:116]CP_EWO_s:9
				End case 
				
				[PRJ_ProjectTimeTracking:124]PT_EWO_s:8:=$ChosenEWO_s
				
			Else 
				CANCEL:C270
			End if 
		Else 
			If (PRJ_MembershipGroup_txt="PRJ_CreateGroup") | (PRJ_MembershipGroup_txt="PRJ_Tool")
			Else 
				OBJECT SET ENABLED:C1123(bValidate; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(bValidate; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				$Color_l:=12
				OBJECT SET ENTERABLE:C238(PRJ_ConsultantReviewers_atxt; False:C215)
				OBJECT SET ENTERABLE:C238(PT_ListofEWOs_atxt; False:C215)
				OBJECT SET ENTERABLE:C238(PT_Scope_atxt; False:C215)
				
			End if 
		End if 
		POPUPMENUC(->PT_Scope_atxt; ->PT_Scope_atxt; ->[PRJ_ProjectTimeTracking:124]PT_Scope_s:11)
		POPUPMENUC(->PT_ListofEWOs_atxt; ->PT_ListofEWOs_as; ->[PRJ_ProjectTimeTracking:124]PT_EWO_s:8)
		POPUPMENUC(->PRJ_ConsultantReviewers_atxt; ->PRJ_ConsultantReviewersID_al; ->[PRJ_ProjectTimeTracking:124]Person ID:3)
		OBJECT SET RGB COLORS:C628(*; "PT@"; Col_paletteToRGB(Abs:C99(-(15+(256*$Color_l)))%256); Col_paletteToRGB(Abs:C99(-(15+(256*$Color_l)))\256))  // **Replaced o OBJECT SET COLOR(*; "PT@"; -(15+(256*$Color_l)))
	: (Form event code:C388=On Unload:K2:2)
		ARRAY TEXT:C222(PT_ListofEWOs_atxt; 0)
		ARRAY TEXT:C222(PT_ListofEWOs_as; 0)  //Command Replaced was o_ARRAY string length was 21
	: (Form event code:C388=On Validate:K2:3)
		PRJ_SetProjectChangesMade(->[PRJ_ProjectTimeTracking:124]; ->[PRJ_ProjectTimeTracking:124]PT_ModifiedBy_s:9; ->[PRJ_ProjectTimeTracking:124]PT_ModifiedTimeStamp_s:10)
		
End case 


//End Form Method: ProjectTimeTracking.i