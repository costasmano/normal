
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 11/29/12, 15:33:27
//----------------------------------------------------
//Method: Form Method: [Inspections];"RailCulvertCombined-RRC"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_11  //r002 ` 
	//Modified by: Charles Miller (11/29/12 15:33:28)
	// Modified by: Costas Manousakis-(Designer)-(1/7/13 16:32:02)
	Mods_2013_01
	//  `Minor changes in the UI Look
	Mods_2013_02  //r001 ` Allow for different headings on weights
	//Modified by: Charles Miller (2/14/13 16:21:20)
	// Modified by: Costas Manousakis-(Designer)-(1/16/18 14:01:16)
	Mods_2018_01
	//  `increased allowed entry in Total Hrs
	Mods_2019_07  //Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafety_SUB"
	//Modified by: Chuck Miller (7/11/19 16:23:30)
	// Modified by: Costas Manousakis-(Designer)-(12/3/19 15:00:43)
	Mods_2019_12
	//  `Named rect on page 2 "WTPostingArea"
	//  `use FORM_HideEnclosedObjs to hide weight posting area
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
	// Modified by: Costas Manousakis-(Designer)-(3/4/21 18:46:51)
	Mods_2021_03
	//  `added proj manager dropdown
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 15:12:25)
	Mods_2021_WP
	//  `
End if 
C_TEXT:C284(vInspTitle)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(CurCat)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($i; $j; $k)  //Command Replaced was o_C_INTEGER

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		INSP_SetWPHeadings
		//try transactions for data entered in include forms and updated via buttons
		START TRANSACTION:C239
		
		//## Initialize transfer data
		InitChangeStack(1)
		InitChangeStack(2)  //for sub-elements-images,fld trips, cond units
		InitChangeStack(3)  //for bms inspections record
		InitChangeStack(4)  //for combined inspections record
		
		//DBD 11/07/02 Cast the var bDivFormValid as boolean and initialized to false 
		C_BOOLEAN:C305(bDiveFormValid)
		bDiveFormValid:=False:C215
		
		INSP_Item43Desc
		INSP_Item107Desc
		//set the title
		vInspTitle:=G_Insp_SetTitle
		G_Insp_FormatInpTitle
		If (Position:C15("Special"; vInspTitle)>0)
			OBJECT SET VISIBLE:C603(*; "@Initial"; True:C214)
			OBJECT SET VISIBLE:C603(*; "@FieldTests@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "@Initial"; False:C215)
			OBJECT SET VISIBLE:C603(*; "@FieldTests@"; False:C215)
		End if 
		
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
		
		INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
		
		INSP_LoadaInspType_
		//Inspection categories for culvert bridge safety inspection
		
		//Added this to replace All Inspections with All Elements
		
		G_InspElmtCatPopup
		
		G_InitInspImages
		
		//Thermometers
		G_SetThermometer(->tItem62; [Inspections:27]Item 62:113)
		G_SetThermometer(->tItem61; [Inspections:27]Item 61:82)
		G_SetThermometer(->tItem62cur; [Inspections:27]Item 62 Cur:172)
		G_SetThermometer(->tItem61cur; [Inspections:27]Item 61 Cur:159)
		
		//DBD 11/04/02 Added items for item62 ddlbs
		If (False:C215)
			POPUPMENUC(->aI62Scour; ->aCollisionCode; ->[Inspections:27]Scour:20)
			POPUPMENUC(->aI62CollisionDamage; ->aCollisionCode; ->[Inspections:27]CollisionDamSup:13)
			POPUPMENUC(->aI62LoadVibration; ->aCollisionCode; ->[Inspections:27]LoadVibration:15)
			POPUPMENUC(->aStreamFlow; ->aStreamCode; ->[Inspections:27]StreamFlowV:21)
		End if 
		
		//Check boxes
		If ([Inspections:27]WeightPosting:30=True:C214)
			CBWeightPos:=0
		Else 
			CBWeightPos:=1
		End if 
		
		Case of 
			: ([Inspections:27]RatingPriority:85="H")
				x1:=1
			: ([Inspections:27]RatingPriority:85="M")
				x2:=1
			: ([Inspections:27]RatingPriority:85="L")
				x3:=1
		End case 
		//Check on security...
		G_SecureInspection
		
		FORM_HideEnclosedObjs("WTPostingArea"; Form current page:K67:6)
		//2004-05-26 ASL
		//This was saved before we started
		RememberCombined
		INSP_PontisCTRL("INIT")
		
		If ([Combined Inspections:90]BMSInspID:3>0)
			If ([BMS Inspections:44]Metric:14)
				tbMetric:=1
				tbEnglish:=0
			Else 
				tbMetric:=0
				tbEnglish:=1
			End if 
		End if 
		
		If (vbInspectionLocked)
			//disable entry if inspection is locked
			G_Insp_LockFormOnOff(True:C214)
		Else 
			//otherwise make sure they are enterable    
			G_Insp_LockFormOnOff(False:C215)
			
			If (([Inspections:27]InspReviewed:12=BMS Not Reviewed) & ([Inspections:27]Item 93b:67=!00-00-00!))
				If ([Bridge MHD NBIS:1]Item92BB:166>0)
					[Inspections:27]Item 93b:67:=[Bridge MHD NBIS:1]Item93B:170
				End if 
				If ([Inspections:27]Item 93b:67#!00-00-00!)
					PushChange(1; ->[Inspections:27]Item 93b:67)
				End if 
			End if 
			INSP_SetUpButtons
			
			
			//ASL 7-8-2003
			//Alert user to differences in dependent data
			CheckDependencies
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
			
			G_Insp_InitPontis
			
		End if   //if inspection locked
		
		G_Insp_SetPersUI
		INSP_SetUI_Rev4
	: ((Form event code:C388=On Close Detail:K2:24) | (Form event code:C388=On Clicked:K2:4))
		
		Case of 
			: (CulvertTabCtrl{FORM Get current page:C276}="Element@")
				//on elementssafety page
				vInspTitle:=G_Insp_SetTitle
				G_Insp_FormatInpTitle
				G_Insp_ElmtArray_setup
				If (Position:C15("Special"; vInspTitle)>0)
					OBJECT SET VISIBLE:C603(*; "@Initial"; True:C214)
					OBJECT SET VISIBLE:C603(*; "@FieldTests@"; True:C214)
				Else 
					OBJECT SET VISIBLE:C603(*; "@Initial"; False:C215)
					OBJECT SET VISIBLE:C603(*; "@FieldTests@"; False:C215)
				End if 
			: (CulvertTabCtrl{FORM Get current page:C276}="Pontis")  //Pontis page
				If (Form event code:C388=On Close Detail:K2:24)
					INSP_PontisCTRL("CLOSEDETAIL")
				End if 
				
		End case 
		
	: (Form event code:C388=On Resize:K2:27)
		INSP_RedrawSubForm_LB  //redraw listboxes in subforms in current tab
		
End case 
//End Form Method: [Inspections]RailCulvertCombined-RRC

