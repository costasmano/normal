// ----------------------------------------------------
// Form Method: SketchPlans.i
// User name (OS): cjmiller
// Date and time: 01/26/06, 16:33:19
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2  //r060   `05/16/07, 15:13:00 `Add code to control access 
	// Modified by: costasmanousakis-(Designer)-(6/18/2007 11:38:01)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(8/23/2007 14:23:58)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(8/30/2007 16:00:18)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/29/2007 08:52:55)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(10/8/08 10:21:57)
	Mods_2008_CM_5404  // ("ACCESS")
	Mods_2011_06  // CJ Miller`06/27/11, 16:26:19      ` If [PRJ_ProjectDetails] locked set to non-enterable
End if 
C_BOOLEAN:C305(PRJ_2ndAddSubRecord_b)
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		ut_SetStringOrTextFilter(->[PRJ_SketchPlans:120]SKT_Comments_txt:4)
		
		C_LONGINT:C283($Color_l)
		$Color_l:=<>PRJ_Color_editable
		
		OBJECT SET ENABLED:C1123(bValidate; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENTERABLE:C238(*; "SKT@"; True:C214)
		OBJECT SET ENABLED:C1123(Button1; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(Button9; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(PRJ_GradingStatus_atxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		If (Record number:C243([PRJ_SketchPlans:120])=New record:K29:1)
			If (PRJ_ReturnAccessAllowed)
				If (PRJ_2ndAddSubRecord_b)
					PRJ_2ndAddSubRecord_b:=False:C215
					CANCEL:C270
				Else 
					[PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3:=PRJ_LastReview_l+1
					[PRJ_SketchPlans:120]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
					[PRJ_SketchPlans:120]SKT_Recieved_d:5:=Current date:C33(*)
					[PRJ_SketchPlans:120]RV_ReviewID_l:2:=[PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39
					OBJECT SET VISIBLE:C603(*; "ReviewerDD@"; True:C214)
				End if 
			Else 
				CANCEL:C270
			End if 
			
		Else 
			If (PRJ_ReturnAccessAllowed)
				OBJECT SET VISIBLE:C603(*; "ReviewerDD@"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "ReviewerDD@"; False:C215)
				OBJECT SET ENABLED:C1123(bValidate; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(bDelete; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(Button1; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(Button9; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(PRJ_GradingStatus_atxt; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				$Color_l:=<>PRJ_Color_Not_editable
				OBJECT SET ENTERABLE:C238(*; "SKT@"; False:C215)
			End if 
		End if 
		PRJ_FillReviewersDisplay(->[PRJ_SketchPlans:120]; [PRJ_SketchPlans:120]RV_ReviewID_l:2)
		OBJECT SET RGB COLORS:C628(*; "SKT@"; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR(*; "SKT@"; $Color_l)
		PRJ_GradingStatus_atxt:=Find in array:C230(PRJ_GradingStatus_atxt; String:C10([PRJ_SketchPlans:120]SKT_GradingStatus_l:16)+"@")
		If (PRJ_GradingStatus_atxt<1)
			PRJ_GradingStatus_atxt:=Size of array:C274(PRJ_GradingStatus_atxt)
		End if 
	: (Form event code:C388=On Validate:K2:3)
		PRJ_LastReviewer_l:=[PRJ_SketchPlans:120]RV_ReviewID_l:2
		PRJ_SetProjectChangesMade(->[PRJ_SketchPlans:120]; ->[PRJ_SketchPlans:120]SKT_ModifiedBy_s:14; ->[PRJ_SketchPlans:120]SKT_ModifiedTimeStamp_s:15)
		
End case 


//End Form Method: SketchPlans.i