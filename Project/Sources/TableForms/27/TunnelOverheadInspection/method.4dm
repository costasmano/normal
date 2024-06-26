If (False:C215)
	//Form Method: [Inspections];"TunnelOverheadInspection" 
	// Modified by: Costas Manousakis-(Designer)-(4/16/13 09:34:27)
	Mods_2013_04
	// Modified by: Costas Manousakis-(Designer)-(11/9/15 17:40:30)
	Mods_2015_11_bug
	//  `modified object methods in fileds 
	//  `[Inspections]NEClrFldFT [Inspections]NEClrFldIN [Inspections]SWClrFldFT [Inspections]SWClrFldIN
	//  `to use method INSP_FieldClr_OM
	// Modified by: Costas Manousakis-(Designer)-(6/15/16 18:02:28)
	Mods_2016_06
	//  `changed title of District Tunnel engr to Distr Inspection engineer
	// Modified by: Costas Manousakis-(Designer)-(1/16/17 12:26:35)
	Mods_2017_01
	//  `added call NTI_LoadAccessibility
	// Modified by: Costas Manousakis-(Designer)-(1/16/18 14:01:16)
	Mods_2018_01
	//  `increased allowed entry in Total Hrs
	Mods_2019_07  //Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafetyTunnel_SUB"
	//Modified by: Chuck Miller (7/11/19 16:23:30)
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 15:12:25)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284(vInspTitle)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(CurCat)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($i; $j; $k)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($pageClicked)  //Command Replaced was o_C_INTEGER

Case of 
	: (Form event code:C388=On Load:K2:1)
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
		InitChangeStack(2)  //for sub-elements
		InitChangeStack(3)  //for bms inspections record
		InitChangeStack(4)  //for combined inspections record
		InitChangeStack(5)  //for Tunnel inspections record
		
		C_BOOLEAN:C305(bDiveFormValid)
		bDiveFormValid:=False:C215
		
		INSP_Item43Desc
		INSP_Item107Desc
		
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
		READ ONLY:C145([TunnelInfo:151])
		QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		LOAD RECORD:C52([TunnelInfo:151])
		QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
		NTI_LoadAccessibility
		INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)
		
		INSP_LoadaInspType_
		
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
		
	: ((Form event code:C388=On Close Detail:K2:24) | (Form event code:C388=On Clicked:K2:4))
		Case of 
			: (vTabRoutingPages{FORM Get current page:C276}="Element@")
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