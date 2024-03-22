//%attributes = {"invisible":true}
//Method: FM_RoutineCombinedInput
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/23/19, 16:10:03
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
	Mods_ChangesMovedto  // moved from v15
End if 
//
C_TEXT:C284(vInspTitle)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(CurCat)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($i; $j; $k)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($pageClicked)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
Case of 
	: ($FormEvent_L=On Load:K2:1)
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
		InitChangeStack(2)  //for sub-elements
		InitChangeStack(3)  //for bms inspections record
		InitChangeStack(4)  //for combined inspections record
		
		C_BOOLEAN:C305(bDiveFormValid)
		bDiveFormValid:=False:C215
		
		INSP_Item43Desc
		INSP_Item107Desc
		
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
		INSP_ResetToOnlyImages
		//Inspection categories for regular bridge safety inspection
		ARRAY TEXT:C222(aInspType_; 0)  //Command Replaced was o_ARRAY string length was 20
		ARRAY TEXT:C222(aInspCod_; 0)  //Command Replaced was o_ARRAY string length was 3
		If (Size of array:C274(<>aInspCod)>0)
			COPY ARRAY:C226(<>aInspCod; aInspCod_)
			COPY ARRAY:C226(<>aInspType; aInspType_)
		Else 
			READ ONLY:C145([Element Cat:32])
			ALL RECORDS:C47([Element Cat:32])
			QUERY SELECTION:C341([Element Cat:32]; [Element Cat:32]RegularElement:4=True:C214)
			SELECTION TO ARRAY:C260([Element Cat:32]Code:1; aInspCod_; [Element Cat:32]Description:2; aInspType_)
			REDUCE SELECTION:C351([Element Cat:32]; 0)
			READ WRITE:C146([Element Cat:32])
		End if 
		
		//Added this to replace All Inspections with All Elements
		$k:=Find in array:C230(aInspCod_; "ALL")
		aInspType_{$k}:="All Elements"
		CurCat:="ALL"
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
		INSP_FieldWorkComplEntry
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
		
		// ****** NBE changes ****
		PON_ChangeStackLvl_L:=2
		PON_ListElements
		PON_NBE_INIT
		
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
		
		
	: (($FormEvent_L=On Close Detail:K2:24) | ($FormEvent_L=On Clicked:K2:4))
		
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
				If ($FormEvent_L=On Close Detail:K2:24)
					INSP_PontisCTRL("CLOSEDETAIL")
				End if 
				
		End case 
		
	: ($FormEvent_L=On Losing Focus:K2:8)
		
	: ($FormEvent_L=On Resize:K2:27)
		INSP_RedrawSubForm_LB  //redraw listboxes in subforms in current tab
		
	: ($FormEvent_L=On Unload:K2:2)
End case 
//End FM_RoutineCombinedInput