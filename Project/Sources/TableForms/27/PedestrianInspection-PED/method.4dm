
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 11/29/12, 13:10:30
//----------------------------------------------------
//Method: Form Method: [Inspections]PedestrianInspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_11  //r002 ` 
	//Modified by: Charles Miller (11/29/12 13:10:31)
	// Modified by: Costas Manousakis-(Designer)-(1/7/13 16:32:02)
	Mods_2013_01
	//  `Minor changes in the UI Look
	Mods_2013_03  //r001 ` $Review2_txt
	//Modified by: Charles Miller (3/12/13 12:39:51)
	Mods_2013_03  //r001 ` Add code to display correct headings on forms based upon [Bridge MHD NBIS]InspResp
	//Modified by: Charles Miller (3/12/13 13:36:40)
	Mods_2019_07  //Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafety_SUB"
	//Modified by: Chuck Miller (7/11/19 16:23:30)
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
	// Modified by: Costas Manousakis-(Designer)-(3/5/21 10:07:58)
	Mods_2021_03
	//  `added project manager dropdown
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 15:12:25)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-12-01)
	Mods_2021_11_bug
	//  `added item 61 data in page 2
End if 
C_TEXT:C284(vInspTitle)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(CurCat)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($i; $j; $k)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($pageClicked)  //Command Replaced was o_C_INTEGER

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
		
		//try transactions for data entered in include forms and updated via buttons
		START TRANSACTION:C239
		
		//## Initialize transfer data
		InitChangeStack(1)
		InitChangeStack(2)  //for sub-elements
		InitChangeStack(3)  //for bms inspections record
		InitChangeStack(4)  //for combined inspections record
		
		C_BOOLEAN:C305(bDiveFormValid)
		bDiveFormValid:=False:C215
		
		INSP_Item43Desc
		INSP_Item107Desc
		
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
		
		INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
		
		INSP_LoadaInspType_
		//Added this to replace All Inspections with All Elements
		
		G_InspElmtCatPopup
		
		//Check boxes
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
		
		POPUPMENUC(->aStreamFlow; ->aStreamCode; ->[Inspections:27]StreamFlowV:21)
		POPUPMENUC(->aPedTraffNE; ->aPedTraffCode; ->[Inspections:27]PedBarricadesNE:83)
		POPUPMENUC(->aPedTraffSW; ->aPedTraffCode; ->[Inspections:27]PedBarricadesSW:84)
		
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
		//set the title
		vInspTitle:=G_Insp_SetTitle
		G_Insp_FormatInpTitle
		If (Position:C15("Special"; vInspTitle)>0)
			OBJECT SET VISIBLE:C603(*; "@Initial"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "@Initial"; False:C215)
		End if 
		//Check on security...
		G_SecureInspection
		
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
			
			G_Insp_InitPontis
			
		End if   //If Inspection locked.
		
		G_Insp_SetPersUI
		INSP_SetUI_Rev4
	: ((Form event code:C388=On Close Detail:K2:24) | (Form event code:C388=On Clicked:K2:4))
		Case of 
			: (vTabRoutingPages{FORM Get current page:C276}="Element Info")
				//on elementssafety page
				G_Insp_ElmtArray_setup
				vInspTitle:=G_Insp_SetTitle
				G_Insp_FormatInpTitle
				If (Position:C15("Special"; vInspTitle)>0)
					OBJECT SET VISIBLE:C603(*; "@Initial"; True:C214)
				Else 
					OBJECT SET VISIBLE:C603(*; "@Initial"; False:C215)
				End if 
			: (vTabRoutingPages{FORM Get current page:C276}="Pontis")  //Pontis page
				If (Form event code:C388=On Close Detail:K2:24)
					INSP_PontisCTRL("CLOSEDETAIL")
				End if 
				
		End case 
		
	: (Form event code:C388=On Resize:K2:27)
		INSP_RedrawSubForm_LB  //redraw listboxes in subforms in current tab
		
End case 
//End Form Method: [Inspections]PedestrianInspection

