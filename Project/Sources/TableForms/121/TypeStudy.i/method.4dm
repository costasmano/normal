// ----------------------------------------------------
// Form Method: TypeStudy.i
// User name (OS): cjmiller
// Date and time: 01/26/06, 15:34:20
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2  //r060   `05/16/07, 15:14:45 `Add code to control access 
	Mods_2007_CM10a
	// Modified by: costasmanousakis-(Designer)-(6/18/2007 11:38:01)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(8/23/2007 14:15:35)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(8/30/2007 16:00:18)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/29/2007 08:58:14)
	Mods_2007_CM12_5302
	Mods_2007_CJM_v54  //r001 `11/13/07, 15:54:48`Make typ_approved_d enetrable only if structure type has value
	// Modified by: costasmanousakis-(Designer)-(10/8/08 10:26:33)
	Mods_2008_CM_5404  // ("ACCESS")
	Mods_2011_06  // CJ Miller`06/27/11, 16:26:19      ` If [PRJ_ProjectDetails] locked set to non-enterable
End if 
C_BOOLEAN:C305(PRJ_2ndAddSubRecord_b)
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		
		C_LONGINT:C283($Color_l)
		$Color_l:=<>PRJ_Color_editable
		
		ut_SetStringOrTextFilter(->[PRJ_TypeStudy:121]TYP_Source_s:6)
		ut_SetStringOrTextFilter(->[PRJ_TypeStudy:121]TYP_StudyType_s:3)
		ut_SetStringOrTextFilter(->[PRJ_TypeStudy:121]TYP_StructureType_s:4)
		ut_SetStringOrTextFilter(->[PRJ_TypeStudy:121]TYP_Comments_txt:12)
		OBJECT SET ENTERABLE:C238(*; "TYP@"; True:C214)
		OBJECT SET ENABLED:C1123(bValidate; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(Btoday; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(Button1; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(PRJ_StructReviewers_atxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(PRJ_GradingStatus_atxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET VISIBLE:C603(*; "ReviewerDD@"; True:C214)
		If (Record number:C243(Current form table:C627->)=New record:K29:1)
			PRJ_SetTypeApproved
			If (PRJ_ReturnAccessAllowed)
				If (PRJ_2ndAddSubRecord_b)
					PRJ_2ndAddSubRecord_b:=False:C215
					CANCEL:C270
				Else 
					[PRJ_TypeStudy:121]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
					[PRJ_TypeStudy:121]TYP_Received_d:5:=Current date:C33(*)
					[PRJ_TypeStudy:121]RV_ReviewID_l:2:=[PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39
				End if 
				
			Else 
				CANCEL:C270
			End if 
			
		Else 
			PRJ_SetTypeApproved
			If (PRJ_ReturnAccessAllowed)
			Else 
				OBJECT SET ENTERABLE:C238(*; "TYP@"; True:C214)
				OBJECT SET ENABLED:C1123(bValidate; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(bDelete; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(PRJ_StructReviewers_atxt; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(Btoday; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(Button1; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(PRJ_GradingStatus_atxt; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				$Color_l:=<>PRJ_Color_Not_editable
			End if 
			
		End if 
		PRJ_FillReviewersDisplay(->[PRJ_TypeStudy:121]; [PRJ_TypeStudy:121]RV_ReviewID_l:2)
		OBJECT SET RGB COLORS:C628(*; "TYP@"; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR(*; "TYP@"; $Color_l)
		
		
		
	: (Form event code:C388=On Validate:K2:3)
		PRJ_LastReviewer_l:=[PRJ_TypeStudy:121]RV_ReviewID_l:2
		PRJ_SetProjectChangesMade(->[PRJ_TypeStudy:121]; ->[PRJ_TypeStudy:121]TYP_ModifiedBy_s:13; ->[PRJ_TypeStudy:121]TYP_ModifiedTimeStamp_s:14)
		
End case 

//End Form Method: TypeStudy.i