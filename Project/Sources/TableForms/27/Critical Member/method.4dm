If (False:C215)
	//LO: [Inspections];"Critical Member"
	
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
	// Modified by: Costas Manousakis-(Designer)-(1/15/15 17:05:25)
	Mods_2015_01
	//  `INSP_FieldWorkComplEntry
	// Modified by: Costas Manousakis-(Designer)-(6/2/15 17:38:53)
	Mods_2015_06
	//  `Added NBE Elements on page 7 and code in the form method
	//  `Adjusted names of "Pontis" related objects on page 5 so they are grouped together
	//  `made tab control Automatic appearance with Top lables
	// Modified by: Costas Manousakis-(Designer)-(2/24/16 15:30:05)
	Mods_2016_02_bug
	//  `changed filter for items  58-62 prev and current to allow entry for N
	// Modified by: Costas Manousakis-(Designer)-(11/20/18 11:34:10)
	Mods_2018_11
	//  `enable Pontis / NBE for Other inspections also
	// Modified by: Costas Manousakis-(Designer)-(5/6/19 12:57:41)
	Mods_2019_05
	//  `use subform [PON_ELEM_INSP];"LB_PON_ELEM_INSP" - moved to back on page to allow Calc HI button to work
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
	// Modified by: Costas Manousakis-(Designer)-(5/7/20 14:37:29)
	Mods_2020_05
	//  `Renamed obj EJDMT Label because it was not 'hiding' inside the weightpostarea.
	// Modified by: Costas Manousakis-(Designer)-(3/4/21 18:49:13)
	Mods_2021_03
	//  `added project manager drop down
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
		
		Case of 
			: ([Inspections:27]Insp Type:6="FCR") | ([Inspections:27]Insp Type:6="RRF")
				OBJECT SET VISIBLE:C603(*; "DE Item58@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "DE Item61@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "DE Item62@"; False:C215)
				OBJECT MOVE:C664(*; "DE Item59@"; 105; 0)
				OBJECT MOVE:C664(*; "DE Item60@"; 105; 0)
				OBJECT MOVE:C664(*; "lblPreviousCondition"; 150; 0)
				OBJECT MOVE:C664(*; "lblCurrentCondition"; 150; 0)
			: ([Inspections:27]Insp Type:6="CMI") | ([Inspections:27]Insp Type:6="RRS")
				OBJECT SET VISIBLE:C603(*; "DE Item61@"; False:C215)
				OBJECT MOVE:C664(*; "DE Item58@"; 60; 0)
				OBJECT MOVE:C664(*; "DE Item59@"; 60; 0)
				OBJECT MOVE:C664(*; "DE Item60@"; 60; 0)
				OBJECT MOVE:C664(*; "lblPreviousCondition"; 60; 0)
				OBJECT MOVE:C664(*; "lblCurrentCondition"; 60; 0)
		End case 
		
		//## Initialize transfer data
		InitChangeStack(1)
		InitChangeStack(2)  //for sub-elements-images,fld trips, cond units
		InitChangeStack(3)  //for bms inspections record
		InitChangeStack(4)  //for combined inspections record
		
		C_BOOLEAN:C305(bDiveFormValid)
		bDiveFormValid:=False:C215
		
		vInspTitle:=[Inspection Type:31]Description:2+" Inspection"
		Case of 
			: (([Inspections:27]Insp Type:6="FCR") | ([Inspections:27]Insp Type:6="RRF"))
				vInspDateLbl:="93a-F.C. Insp Date"
			: (([Inspections:27]Insp Type:6="CMI") | ([Inspections:27]Insp Type:6="RRS"))
				vInspDateLbl:="93*-S.M. Insp Date"
				APPEND TO ARRAY:C911(vTabRoutingPages; "Pontis")
			: ([Inspections:27]Insp Type:6="OTH")
				APPEND TO ARRAY:C911(vTabRoutingPages; "Pontis")
				vInspDateLbl:="Inspection Date"
			: ([Inspections:27]Insp Type:6="RRO")
				vInspDateLbl:="Inspection Date"
				
		End case 
		
		INSP_Item43Desc
		INSP_Item107Desc
		
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
		
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
		//Check on security...
		G_SecureInspection
		//This was saved before we started
		RememberCombined
		INSP_PontisCTRL("INIT")
		
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