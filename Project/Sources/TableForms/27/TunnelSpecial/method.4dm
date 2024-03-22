If (False:C215)
	//Form Method: [Inspections];"TunnelSpecial "
	
	Mods_2004_CM12
	Mods_2005_CM05
	Mods_2005_CM06
	Mods_2005_CM08
	Mods_2005_CM01
	Mods_2005_VN01
	Mods_2005_VN03
	// Modified by: costasmanousakis-(Designer)-(4/9/2007 08:50:05)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 15:26:18)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(4/09/09 11:59:38)
	Mods_2009_04
	//  `Removed the call to G_InitInspVars
	// Modified by: costasmanousakis-(Designer)-(2/26/10 12:15:11)
	Mods_2010_02
	//  `Add Pontis tab for CMI inspections in the form and in code
	// Modified by: Costas Manousakis-(Designer)-(5/9/12 17:14:17)
	Mods_2012_05
	//  `Renamed the format pulldowns and changed the code there to call  WRUTIL_Function
	// Modified by: Costas Manousakis-(Designer)-(12/8/12 21:07:31)
	Mods_2012_12
	//  `Moved and resized objects in the comments page for better visual when menu is shown in 4D Write areas.
	// Modified by: Costas Manousakis-(Designer)-(1/2/13 09:43:48)
	Mods_2013_01
	//  `Use new method Insp_SortElmtSfty and  INSP_LoadElmLabelsforReport for RR@ inspection types
	//  `Add the cases for RRF, RRS, RRO  types 
	// Modified by: Costas Manousakis-(Designer)-(1/7/13 16:32:02)
	Mods_2013_01
	//  `Minor changes in the UI Look 
	Mods_2013_02  //r001 `  Allow for different headings on weight postings
	//Modified by: Charles Miller (2/19/13 16:56:23)
	Mods_2013_03  //r001 ` Add code to display correct headings on forms based upon [Bridge MHD NBIS]InspResp
	//Modified by: Charles Miller (3/12/13 12:01:37)
	// Modified by: Costas Manousakis-(Designer)-(8/11/14 12:00:29)
	Mods_2014_08
	//  `fixed label for insp date (was 90- routine insp date)
	// Modified by: Costas Manousakis-(Designer)-(6/15/16 18:02:28)
	Mods_2016_06
	//  `changed title of District Tunnel engr to Distr Inspection engineer
	Mods_2019_07  //Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafetyTunnelS_SUB"
	//Modified by: Chuck Miller (7/11/19 16:23:30)
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 15:12:25)
	Mods_2021_WP
	//  `
End if 
C_TEXT:C284(vInspTitle; vInspDateLbl)  // Command Replaced was o_C_STRING length was 255
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
		
		C_TEXT:C284(CurCat)  // Command Replaced was o_C_STRING length was 3
		CurCat:="ALL"
		
		//## Initialize transfer data
		InitChangeStack(1)
		InitChangeStack(2)  //for sub-elements-images,fld trips, cond units
		InitChangeStack(3)  //for bms inspections record
		InitChangeStack(4)  //for combined inspections record
		InitChangeStack(5)  //for tunnel inspections record
		
		C_BOOLEAN:C305(bDiveFormValid)
		bDiveFormValid:=False:C215
		
		vInspTitle:=[Inspection Type:31]Description:2+" Inspection"
		vInspDateLbl:="93*-S.M. Insp Date"
		
		INSP_Item43Desc
		INSP_Item107Desc
		
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
		
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
		//This was saved before we started
		RememberCombined
		INSP_PontisCTRL("INIT")
		
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
		
	: (Form event code:C388=On Close Detail:K2:24)
		
		Case of 
			: (vTabRoutingPages{FORM Get current page:C276}="Element Info")
				//on elementssafety page
				G_Insp_ElmtArray_setup
			: (vTabRoutingPages{FORM Get current page:C276}="@Pontis@")  //on Ponits page
				INSP_PontisCTRL("CLOSEDETAIL")
		End case 
		
	: (Form event code:C388=On Resize:K2:27)
		INSP_RedrawSubForm_LB  //redraw listboxes in subforms in current tab
		
End case 