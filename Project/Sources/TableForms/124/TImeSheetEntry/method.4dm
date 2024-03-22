// ----------------------------------------------------
// Form Method: TImeSheetEntry
// User name (OS): cjmiller
// Date and time: 05/16/07, 15:17:44
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2  //r060   `05/16/07, 15:17:46 `Add code to control access 
	Mods_PRJSELECTION
	// Modified by: costasmanousakis-(Designer)-(3/1/09 23:37:10)
	Mods_2009_CM_5404  //----TIMESHEETS2
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		ut_SetStringOrTextFilter(->[PRJ_ProjectTimeTracking:124]PT_Coments_txt:5)
		ut_SetStringOrTextFilter(->[PRJ_ProjectTimeTracking:124]PT_EWO_s:8)
		aViewDesign:=1
		aViewConstruction:=0
		C_LONGINT:C283($Color_l)
		$Color_l:=0
		OBJECT SET VISIBLE:C603(PT_ConstructionProjectList_HL; False:C215)
		OBJECT SET VISIBLE:C603(PT_DesignProjectList_HL; True:C214)
		OBJECT SET VISIBLE:C603(*; "PT_Scope_@"; True:C214)
		
		OBJECT SET ENABLED:C1123(bValidate; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENTERABLE:C238(PRJ_ConsultantReviewers_atxt; True:C214)
		OBJECT SET ENTERABLE:C238(PT_DesignProjectList_HL; True:C214)
		OBJECT SET ENTERABLE:C238(PT_CostCodeName_atxt; True:C214)
		OBJECT SET ENABLED:C1123(aViewDesign; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(aViewConstruction; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		
		OBJECT SET RGB COLORS:C628(*; "PT@"; Col_paletteToRGB(Abs:C99(-(15+(256*$Color_l)))%256); Col_paletteToRGB(Abs:C99(-(15+(256*$Color_l)))\256))  // **Replaced o OBJECT SET COLOR(*; "PT@"; -(15+(256*$Color_l)))
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
	: (Form event code:C388=On Validate:K2:3)
		//PRJ_SetProjectChangesMade (->[PRJ_ProjectTimeTracking];->[PRJ_ProjectTimeTracking]PT_ModifiedBy_s;->[PRJ_ProjectTimeTracking]PT_ModifiedTimeStamp_s)
		
End case 

//End Form Method: TImeSheetEntry