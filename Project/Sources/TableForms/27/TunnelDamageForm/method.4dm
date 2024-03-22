If (False:C215)
	//Form Method: [Inspections]TunnelDamageForm 
	// created by: Costas Manousakis-(Designer)-(1/6/15 10:10:50)
	// copy from Damage form
	Mods_2015_01
	//  `
	// Modified by: Costas Manousakis-(Designer)-(11/9/15 17:40:30)
	Mods_2015_11_bug
	//  `modified object methods in fileds 
	//  `[Inspections]NEClrFldFT [Inspections]NEClrFldIN [Inspections]SWClrFldFT [Inspections]SWClrFldIN
	//  `to use method INSP_FieldClr_OM
	// Modified by: Costas Manousakis-(Designer)-(6/15/16 18:02:28)
	Mods_2016_06
	//  `changed title of District Tunnel engr to Distr Inspection engineer
	// Modified by: Costas Manousakis-(Designer)-(8/29/17 11:17:33)
	Mods_2017_08_bug
	//  `Fix Labels on N-S/E-W 
	Mods_2019_07  //Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafetyTunnelS_SUB"
	//Modified by: Chuck Miller (7/11/19 16:23:30)
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
End if 

C_TEXT:C284(vInspTitle)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($i; $j; $k)  //Command Replaced was o_C_INTEGER

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
		//## Initialize transfer data
		InitChangeStack(1)
		InitChangeStack(2)  //for sub-elements-images,fld trips, cond units
		InitChangeStack(3)  //for bms inspections record
		InitChangeStack(4)  //for combined inspections record
		InitChangeStack(5)  //for tunnel inspections record
		
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
		
		C_TEXT:C284(CurCat)  // Command Replaced was o_C_STRING length was 3
		CurCat:="ALL"
		//Sort Elements
		READ ONLY:C145([TunnelInfo:151])
		QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		LOAD RECORD:C52([TunnelInfo:151])
		QUERY:C277([TunnelInspection:152]; [TunnelInspection:152]InspID:1=[Inspections:27]InspID:2)
		
		INSP_LoadElmLabelsforReport("TAL")
		
		Insp_SortElmtSfty([Inspections:27]Insp Type:6)
		
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
			OBJECT SET ENABLED:C1123(*; "DE Button Accept"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
	: (Form event code:C388=On Close Detail:K2:24)
		Case of 
			: (vTabRoutingPages{FORM Get current page:C276}="Element Info")
				//on elementssafety page
				G_Insp_ElmtArray_setup
				
			: (FORM Get current page:C276=6)
				//on Images page
		End case 
		
		
	: (Form event code:C388=On Resize:K2:27)
		INSP_RedrawSubForm_LB  //redraw listboxes in subforms in current tab
		
End case 