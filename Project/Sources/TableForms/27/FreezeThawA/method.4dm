// Method: Form Method: [Inspections]FreezeThawA
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 02/07/14, 12:26:03
	// ----------------------------------------------------
	// First Release
	Mods_2014_02
	Mods_2019_07  //Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafety_SUB"
	//Modified by: Chuck Miller (7/11/19 16:23:30)
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
	// Modified by: Costas Manousakis-(Designer)-(6/2/20 17:02:33)
	Mods_2020_06
	//  `added designated Team leader - CallReference #714
	// Modified by: Costas Manousakis-(Designer)-(3/4/21 19:07:18)
	Mods_2021_03
	//  `added project manager drop down
End if 

C_TEXT:C284(vInspTitle; vInspDateLbl)  // Command Replaced was o C_STRING length was 255
C_TEXT:C284(CurCat)  // Command Replaced was o C_STRING length was 3

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		Case of 
			: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
				OBJECT SET VISIBLE:C603(*; "MBTAText@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "NonMBTAText@"; False:C215)
				
			Else 
				OBJECT SET VISIBLE:C603(*; "MBTAText@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "NonMBTAText@"; True:C214)
				
		End case 
		START TRANSACTION:C239
		//## Initialize transfer data
		InitChangeStack(1)
		C_LONGINT:C283(FRZNoProblem_L; FRZNotAppl_L; FRZNoAction_L; $loop_L)
		C_BOOLEAN:C305(bDiveFormValid)
		bDiveFormValid:=False:C215
		C_TEXT:C284(FRZFieldTests_txt)
		vInspTitle:=[Inspection Type:31]Description:2+" Inspection"
		vInspDateLbl:="Inspection Date"
		INSP_Item43Desc
		INSP_Item107Desc
		OBJECT SET VISIBLE:C603(*; "PrintPreviewPicture"; False:C215)
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
		ORDER BY:C49([ElementsSafety:29]InspID:4; [ElementDict:30]ElementNo:1; >)
		CurCat:="ALL"
		ARRAY LONGINT:C221(alElmtSftyPulldwnID; 0)
		ARRAY INTEGER:C220($elmtNo_ai; 0)
		SELECTION TO ARRAY:C260([ElementsSafety:29]ElmSafetyID:7; alElmtSftyPulldwnID; [ElementsSafety:29]ElementNo:1; $elmtNo_ai)
		ARRAY TEXT:C222(asElmtSftyPulldwnName; Size of array:C274(alElmtSftyPulldwnID))  //Command Replaced was o_ARRAY string length was 80
		For ($loop_L; 1; Size of array:C274(alElmtSftyPulldwnID))
			asElmtSftyPulldwnName{$loop_L}:=INSP_FRZElmtDesc($elmtNo_ai{$loop_L})
		End for 
		
		//Images
		G_InitInspImages
		//Check on security...
		G_SecureInspection
		
		If (vbInspectionLocked)
			//disable entry if inspection is locked
			G_Insp_LockFormOnOff(True:C214)
		Else 
			//otherwise make sure they are enterable    
			G_Insp_LockFormOnOff(False:C215)
			
			If ((([Inspections:27]InspReviewed:12=BMS Not Reviewed)) & ([Inspections:27]Item 93b:67=!00-00-00!))
				If ([Bridge MHD NBIS:1]Item92BB:166>0)
					[Inspections:27]Item 93b:67:=[Bridge MHD NBIS:1]Item93B:170
				End if 
				If ([Inspections:27]Item 93b:67#!00-00-00!)
					PushChange(1; ->[Inspections:27]Item 93b:67)
				End if 
			End if 
			//Alert user to differences in dependent data
			CheckDependencies
			
			G_ReplyBtnCfg
			
		End if 
		
		G_Insp_SetPersUI
		
	: (Form event code:C388=On Resize:K2:27)
		INSP_RedrawSubForm_LB  //redraw listboxes in subforms in current tab
		
End case 