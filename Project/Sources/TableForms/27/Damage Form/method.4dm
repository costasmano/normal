
If (False:C215)
	//FM:[Inspections];"Damage Form"
	
	Mods_2004_CM12
	Mods_2005_CM05
	Mods_2005_CM06
	Mods_2005_CM08
	// Modified by: costasmanousakis-(Designer)-(4/17/2007 08:32:54)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 15:38:00)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(4/09/09 11:59:38)
	Mods_2009_04
	//  `Removed the call to G_InitInspVars
	// Modified by: Costas Manousakis-()-(1/5/12 10:24:13)
	Mods_2012_01
	//  `Remoived code that was calculating the MinFieldClr when Posted Clearance values were changed
	// Modified by: Costas Manousakis-(Designer)-(5/9/12 17:16:48)
	Mods_2012_05
	//  `Renamed the format pulldowns and changed the code there to call  WRUTIL_Function
	// Modified by: Costas Manousakis-(Designer)-(12/8/12 21:07:31)
	Mods_2012_12
	//  `Moved and resized objects in the comments page for better visual when menu is shown in 4D Write areas.
	// Modified by: Costas Manousakis-(Designer)-(1/2/13)
	Mods_2013_01
	//  `Use new method Insp_SortElmtSfty and  INSP_LoadElmLabelsforReport for RR@ inspection types
	// Modified by: Costas Manousakis-(Designer)-(1/7/13 16:32:02)
	Mods_2013_01
	//  `Minor changes in the UI Look
	Mods_2013_02  //r001 ` Allow for different headings on weights
	//Modified by: Charles Miller (2/14/13 16:19:30)
	Mods_2013_03  //r001 ` Add code to display correct headings on forms based upon [Bridge MHD NBIS]InspResp
	//Modified by: Charles Miller (3/12/13 12:03:19)
	// Modified by: Costas Manousakis-(Designer)-(11/9/15 17:40:30)
	Mods_2015_11_bug
	//  `modified object methods in fileds 
	//  `[Inspections]NEClrFldFT [Inspections]NEClrFldIN [Inspections]SWClrFldFT [Inspections]SWClrFldIN
	//  `to use method INSP_FieldClr_OM
	// Modified by: Costas Manousakis-(Designer)-(11/9/18 12:28:24)
	Mods_2018_11
	//  `when blnBostonOffice is true, make sure [Inspections] record in loaded Read write
	Mods_2019_07  //Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafetyCM_SUB"
	//Modified by: Chuck Miller (7/11/19 16:23:30)
	// Modified by: Costas Manousakis-(Designer)-(12/3/19 14:54:47)
	Mods_2019_12
	//  `named rectangle "WTPostingArea" around weight posting group on page 2
	//  `use FORM_HideEnclosedObjs to hide weight posting area
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
	// Modified by: Costas Manousakis-(Designer)-(3/4/21 18:57:50)
	Mods_2021_03
	//  `added project manager dropdown
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 15:12:25)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284(vInspTitle)  // old C_STRING length 255
C_LONGINT:C283($i; $j; $k)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER

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
		
		INSP_SetWPHeadings
		//try transactions for data entered in include forms and updated via buttons
		START TRANSACTION:C239
		
		//## Initialize transfer data
		InitChangeStack(1)
		
		//Lock the Boston Office page
		C_BOOLEAN:C305(blnBostonOffice)
		blnBostonOffice:=User in group:C338(Current user:C182; "InspectionReview")
		blnBostonOffice:=(blnBostonOffice | (Current user:C182="designer"))
		
		C_BOOLEAN:C305(bDiveFormValid)
		bDiveFormValid:=False:C215
		
		vInspTitle:=[Inspection Type:31]Description:2+" Inspection"
		
		INSP_Item43Desc
		INSP_Item107Desc
		
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
		
		C_TEXT:C284(CurCat)  // old C_STRING length 3
		CurCat:="ALL"
		//Sort Elements
		Case of 
			: ([Inspections:27]Insp Type:6="RR@")
				INSP_LoadElmLabelsforReport([Inspections:27]BaseType_s:215)
				Insp_SortElmtSfty([Inspections:27]BaseType_s:215)
				FORM_HideEnclosedObjs("WTPostingArea"; Form current page:K67:6)  // hide weight posting at the same page
			Else 
				//INSP_LoadElmLabelsforReport ([Inspections]BaseType_txt)
				Insp_SortElmtSfty
		End case 
		G_Insp_ElmtArray_setup
		
		If ([Inspections:27]WeightPosting:30=True:C214)
			CBWeightPos:=0
		Else 
			CBWeightPos:=1
		End if 
		If ([Inspections:27]ClrPosting:49=True:C214)
			CBClrPost:=0
		Else 
			CBClrPost:=1
		End if 
		
		Case of 
			: ([Inspections:27]RatingPriority:85="H")
				x1:=1
			: ([Inspections:27]RatingPriority:85="M")
				x2:=1
			: ([Inspections:27]RatingPriority:85="L")
				x3:=1
		End case 
		
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
			
			OBJECT SET ENTERABLE:C238(*; "DE Clr@"; ((CBClrPost=0)))
			If (CBClrPost=0)
				OBJECT SET RGB COLORS:C628(*; "DE Clr@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Clr@"; <>Color_Editable)
			Else 
				OBJECT SET RGB COLORS:C628(*; "DE Clr@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Clr@"; <>Color_Not_Editable)
			End if 
			
			//ASL 7-8-2003
			//Alert user to differences in dependent data
			CheckDependencies
			
			//Re-do Check boxes if weight posting changed.
			If ([Inspections:27]WeightPosting:30=True:C214)
				CBWeightPos:=0
			Else 
				CBWeightPos:=1
			End if 
			OBJECT SET ENTERABLE:C238(*; "DE Wt@"; ((CBWeightPos=0)))
			If (CBWeightPos=0)
				OBJECT SET RGB COLORS:C628(*; "DE Wt@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Wt@"; <>Color_Editable)
			Else 
				OBJECT SET RGB COLORS:C628(*; "DE Wt@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Wt@"; <>Color_Not_Editable)
			End if 
			G_ReplyBtnCfg
			
		End if 
		
		G_Insp_SetPersUI
		INSP_SetUI_Rev4
		OBJECT SET ENTERABLE:C238(*; "Dam Boston @"; blnBostonOffice)
		If (blnBostonOffice)
			If (Read only state:C362([Inspections:27]))
				If (Not:C34(ut_LoadRecordInteractive(->[Inspections:27])))
					ALERT:C41("Unable to edit the current Damage inspection report!")
				End if 
			End if 
			//enable the save buttons depending on whether [inspections] has been loaded RW or RO
			OBJECT SET ENABLED:C1123(*; "DE Button Accept@"; Not:C34(Read only state:C362([Inspections:27])))  // **replaced _ o _ENABLE BUTTON(*;"DE Button Accept")
			OBJECT SET ENABLED:C1123(*; "DE Button Save@"; Not:C34(Read only state:C362([Inspections:27])))
			
		End if 
		
	: (Form event code:C388=On Close Detail:K2:24)
		Case of 
			: (FORM Get current page:C276=3)
				//on elementssafety page
				G_CountSpInspPgs
				G_Insp_ElmtArray_setup
				
			: (FORM Get current page:C276=6)
				//on Images page
				G_CountSpInspPgs
		End case 
		
	: (Form event code:C388=On Resize:K2:27)
		INSP_RedrawSubForm_LB  //redraw listboxes in subforms in current tab
		
		
End case 