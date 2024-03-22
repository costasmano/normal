If (False:C215)
	//[Inspections];"Closed Bridge"
	
	Mods_2004_CM12
	Mods_2005_CM05
	Mods_2005_CM06
	Mods_2005_CM08
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 15:34:48)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(4/09/09 11:59:38)
	Mods_2009_04
	//  `Removed the call to G_InitInspVars
	// Modified by: Costas Manousakis-(Designer)-(5/9/12 17:16:48)
	Mods_2012_05
	//  `Renamed the format pulldowns and changed the code there to call  WRUTIL_Function
	// Modified by: Costas Manousakis-(Designer)-(12/8/12 21:07:31)
	Mods_2012_12
	//  `Moved and resized objects in the comments page for better visual when menu is shown in 4D Write areas.
	// Modified by: Costas Manousakis-(Designer)-(1/7/13 16:32:02)
	Mods_2013_01
	//  `Minor changes in the UI Look 
	//  `Use new method Insp_SortElmtSfty and  INSP_LoadElmLabelsforReport for RR@ inspection types
	
	Mods_2013_03  //r001 ` Add code to display correct headings on forms based upon [Bridge MHD NBIS]InspResp
	//Modified by: Charles Miller (3/12/13 13:57:14)
	// Modified by: Costas Manousakis-(Designer)-(11/18/13 09:45:22)
	Mods_2013_11
	//  `fixed display format of amount for large numbers
	// Modified by: Costas Manousakis-(Designer)-(1/15/15 17:04:39)
	Mods_2015_01
	//  `INSP_FieldWorkComplEntry
	// Modified by: Costas Manousakis-(Designer)-(6/1/15 14:26:35)
	Mods_2015_06_bug
	//  `fixed entry filter in Items 60,61,62 UW
	// Modified by: Costas Manousakis-(Designer)-(1/16/18 14:01:16)
	Mods_2018_01
	//  `increased allowed entry in Total Hrs
	Mods_2019_07  //Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafety_SUB"
	//Change to use the following subforms
	//[Standard Photos];"LBStdPhotos"
	//[ElementsSafety];"ElementSafety_SUB"
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 15:11:06)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284(vInspTitle)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($i; $j; $k)  //Command Replaced was o_C_INTEGER

C_BOOLEAN:C305(blnDBIE)

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
		Case of 
			: ([Inspections:27]Cld_Schedule:194="1")
				x1:=1
			: ([Inspections:27]Cld_Schedule:194="2")
				x2:=1
			: ([Inspections:27]Cld_Schedule:194="3")
				x3:=1
			: ([Inspections:27]Cld_Schedule:194="4")
				x4:=1
			: ([Inspections:27]Cld_Schedule:194="5")
				x5:=1
		End case 
		//Only the DBIE can enter these    
		If (False:C215)
			blnDBIE:=(Current user:C182=<>DBIED1Uname) | (Current user:C182=<>DBIED2Uname) | (Current user:C182=<>DBIED3Uname) | (Current user:C182=<>DBIED4Uname) | (Current user:C182=<>DBIED5Uname)
		End if 
		blnDBIE:=User in group:C338(Current user:C182; "Inspection Engineers")
		blnDBIE:=(blnDBIE | (Current user:C182="designer"))
		//## Initialize transfer data
		InitChangeStack(1)
		
		C_BOOLEAN:C305(bDiveFormValid)
		bDiveFormValid:=False:C215
		
		vInspTitle:=[Inspection Type:31]Description:2+" Inspection"
		
		INSP_Item43Desc
		INSP_Item107Desc
		
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
		
		//Check boxes    
		If ([Inspections:27]ClosedSigns:118=False:C215)
			CBCldPost:=1
		Else 
			CBCldPost:=0
		End if 
		
		C_TEXT:C284(CurCat)  // Command Replaced was o_C_STRING length was 3
		CurCat:="ALL"
		//ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
		INSP_LoadElmLabelsforReport([Inspections:27]BaseType_s:215)
		Insp_SortElmtSfty
		
		G_Insp_ElmtArray_setup
		
		POPUPMENUC(->aPedTraffNE; ->aPedTraffCode; ->[Inspections:27]PedBarricadesNE:83)
		POPUPMENUC(->aPedTraffSW; ->aPedTraffCode; ->[Inspections:27]PedBarricadesSW:84)
		
		INSP_FieldWorkComplEntry
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
			
			OBJECT SET ENTERABLE:C238(*; "DE Sgn@"; (CBCldPost=0))
			//ASL 7-8-2003
			//Alert user to differences in dependent data
			CheckDependencies
			
			G_ReplyBtnCfg
			
			If ([Inspections:27]ClosedSigns:118)
				CBCldPost:=0
			Else 
				CBCldPost:=1
			End if 
			OBJECT SET ENTERABLE:C238(*; "DE Sgn@"; ((CBCldPost=0)))
			If (CBCldPost=0)
				OBJECT SET RGB COLORS:C628(*; "DE Sgn@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Sgn@"; <>Color_Editable)
			Else 
				OBJECT SET RGB COLORS:C628(*; "DE Sgn@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Sgn@"; <>Color_Not_Editable)
			End if 
			
		End if   //if(Locked)
		
		G_Insp_SetPersUI
		
		If (blnDBIE=True:C214)
			OBJECT SET ENABLED:C1123(*; "DBIE@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(*; "DBIE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		If ([Inspections:27]Cld_UnderConstruction:195)
			CBCldUnderConstruction:=1
		Else 
			CBCldUnderConstruction:=0
		End if 
		
		If (([Inspections:27]Cld_UnderConstruction:195) & Not:C34(vbInspectionLocked))
			//unlock fields
			OBJECT SET ENTERABLE:C238(*; "DBIE Cld @"; True:C214 & blnDBIE)
			If (blnDBIE)
				OBJECT SET RGB COLORS:C628(*; "DBIE Cld @"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DBIE Cld @"; <>Color_Editable)
			Else 
				OBJECT SET RGB COLORS:C628(*; "DBIE Cld @"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DBIE Cld @"; <>Color_Not_Editable)
			End if 
			
		Else 
			//lock fields
			OBJECT SET ENTERABLE:C238(*; "DBIE Cld @"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "DBIE Cld @"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DBIE Cld @"; <>Color_Not_Editable)
		End if 
		
	: (Form event code:C388=On Close Detail:K2:24)
		If (FORM Get current page:C276=2)
			//on elementssafety page
			G_Insp_ElmtArray_setup
		End if 
		
	: (Form event code:C388=On Resize:K2:27)
		INSP_RedrawSubForm_LB  //redraw listboxes in subforms in current tab
		
End case 