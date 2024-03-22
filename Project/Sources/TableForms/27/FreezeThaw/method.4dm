If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/16/09, 10:28:05
	// ----------------------------------------------------
	// Method: Form Method: FreezeThaw
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	Mods_2009_CM_5404  //Copied to Server on : 03/20/09, 08:36:03  ` ("FREEZETHAW")  `-bug fix
	//fix size  of include list on page 2
	
	// Modified by: costasmanousakis-(Designer)-(4/9/09 19:30:44)
	Mods_2009_04
	//Set the Elements Included list to Don't Add on Double click on blank line
	//Removed call to G_InitInspVars, now it is called from the BlankStarterCombined form method
	// Modified by: costasmanousakis-(Designer)-(7/23/10 10:21:16)
	Mods_2010_07
	//  `Added the Info Button on the second page
	Mods_2011_06  // CJ Miller`06/20/11, 11:07:38      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(5/23/12 16:13:59)
	Mods_2012_05
	//  `Adjusted size and position of objects on page1
	// Modified by: Costas Manousakis-(Designer)-(1/7/13 16:32:02)
	Mods_2013_01
	//  `Minor changes in the UI Look
	Mods_2013_03  //r001 ` Add code to display correct headings on forms based upon [Bridge MHD NBIS]InspResp
	//Modified by: Charles Miller (3/12/13 12:08:30)
	Mods_2019_07  //Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafety_SUB"
	//Modified by: Chuck Miller (7/11/19 16:23:30)
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
	// Modified by: Costas Manousakis-(Designer)-(3/4/21 19:01:33)
	Mods_2021_03
	//  `added project manager drop down
End if 
C_TEXT:C284(vInspTitle; vInspDateLbl)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(CurCat)  // Command Replaced was o_C_STRING length was 3

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