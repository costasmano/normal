//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/19/06, 11:14:57
	// ----------------------------------------------------
	// Method: INSP_UWInputForm_FM
	// Description
	// Form method for all Underwater Inspection input forms
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy2
	// Modified by: costasmanousakis-(Designer)-(4/9/09 21:04:07)
	Mods_2009_04
	//  `Removed the call to G_InitInspVars
	Mods_2013_05  //r003 `  Change [Element Cat]Description from 15 to 20 characters
	//Modified by: Charles Miller (5/14/13 13:59:28)
	// Modified by: Costas Manousakis-(Designer)-(9/25/17 13:32:36)
	Mods_2017_09
	//  `build TM and TL arrays depending on the users'  Company / Agency
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 14:37:29)
	Mods_2020_02
	//  `Enabled on Resize event on form and added form even in method to call INSP_RedrawSubForm_LB
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		C_TEXT:C284(vInspTitle)  // Command Replaced was o_C_STRING length was 255
		C_TEXT:C284(CurCat)  // Command Replaced was o_C_STRING length was 3
		C_TEXT:C284(vUOE)  // Command Replaced was o_C_STRING length was 44
		C_TEXT:C284(vDiveMaster)  // Command Replaced was o_C_STRING length was 44
		
		//3-3-2001 ASL this was missing
		//## Initialize transfer data
		InitChangeStack(1)
		InitChangeStack(4)
		
		vInspTitle:=[Inspection Type:31]Description:2+" Inspection"
		
		INSP_aUOE_OM
		//build arrays based on company of current user
		ARRAY TEXT:C222($firstname; 0)  //Command Replaced was o_ARRAY string length was 44
		ARRAY TEXT:C222($midname; 0)
		ARRAY TEXT:C222($lastname; 0)
		ARRAY INTEGER:C220($jobCode; 0)
		ARRAY TEXT:C222(aDiveMaster; 0)  //Command Replaced was o_ARRAY string length was 44
		ARRAY INTEGER:C220(aDiveMasterID; 0)
		READ ONLY:C145([Personnel:42])
		QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8=2; *)  //TL
		QUERY:C277([Personnel:42];  | ; [Personnel:42]Job Code:8=1; *)  //UOE
		QUERY:C277([Personnel:42];  | ; [Personnel:42]Job Code:8=3; *)  // or team member
		QUERY:C277([Personnel:42];  & ; [Personnel:42]DiveTeam:10=True:C214; *)
		QUERY:C277([Personnel:42];  & ; [Personnel:42]Active:11=True:C214)
		
		Case of 
			: (<>PERS_MyCompany_txt="MHD Underwater Oper.@") | (<>PERS_MyCompany_txt="Mass. Highway Dept.@")
				QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Employer:9="MHD Underwater Oper.@"; *)
				QUERY SELECTION:C341([Personnel:42];  | ; [Personnel:42]Employer:9="Mass. Highway Dept.@")
				
			: (<>PERS_MyCompany_txt#"")
				QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Employer:9=<>PERS_MyCompany_txt)
			Else 
				
		End case 
		
		ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; [Personnel:42]First Name:3; [Personnel:42]Middle Name:4)
		SELECTION TO ARRAY:C260([Personnel:42]First Name:3; $firstname; [Personnel:42]Middle Name:4; $midname; [Personnel:42]Last Name:5; $lastname; [Personnel:42]Person ID:1; $aPersonID; [Personnel:42]Job Code:8; $jobCode)
		C_LONGINT:C283($loop_L)
		
		For ($loop_L; 1; Size of array:C274($firstname))
			//Concatenate the names.  
			If ($midname{$loop_L}#"")
				$firstname{$loop_L}:=$firstname{$loop_L}+" "+$midname{$loop_L}
			End if 
			$firstname{$loop_L}:=$firstname{$loop_L}+" "+$lastname{$loop_L}
		End for 
		//set up the TeamMembers first
		COPY ARRAY:C226($firstname; aTeamMbr)
		COPY ARRAY:C226($aPersonID; aTeamMbrID)
		
		//now leave only the TLs or UOE - for MHD/Mass DOT keep the list
		
		If (<>PERS_MyCompany_txt#"MHD Underwater Oper.@") & (<>PERS_MyCompany_txt#"Mass. Highway Dept.@")
			
			For ($loop_L; Size of array:C274($firstname); 1; -1)
				If ($jobCode{$loop_L}=3)  //remove Team members
					DELETE FROM ARRAY:C228($firstname; $loop_L; 1)
					DELETE FROM ARRAY:C228($aPersonID; $loop_L; 1)
					DELETE FROM ARRAY:C228($jobCode; $loop_L; 1)
				End if 
				
			End for 
			
		End if 
		
		COPY ARRAY:C226($firstname; aDiveMaster)
		COPY ARRAY:C226($aPersonID; aDiveMasterID)
		
		INSP_aDiveMaster_OM
		
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)
		
		INSP_BuildTmMbrArea
		
		POPUPMENUC(->aInspLevel_; ->aInspLevelCod_; ->[Inspections:27]LevelofInsp:105)
		
		//Inspection categories for regular bridge safety inspection
		//3/25/2001 ASL
		//Populate this array explicitly
		//Set the of the array
		ARRAY TEXT:C222(aInspType_; 6)  //Command Replaced was o_ARRAY string length was 20
		ARRAY TEXT:C222(aInspCod_; 6)  //Command Replaced was o_ARRAY string length was 3
		//Add Item 58
		aInspType_{1}:="Deck"
		aInspCod_{1}:="N58"
		aInspType_{2}:="Superstructure"
		aInspCod_{2}:="N59"
		aInspType_{3}:="Substructure"
		aInspCod_{3}:="N60"
		aInspType_{4}:="Channel"
		aInspCod_{4}:="N61"
		aInspType_{5}:="Culvert"
		aInspCod_{5}:="N62"
		aInspType_{6}:="All Elements"  //9-10-01 chgd from all inspection to elements
		aInspCod_{6}:="ALL"
		CurCat:="ALL"
		
		G_InspElmtCatPopup
		
		G_InitInspImages  //init image counters
		RememberCombined
		
		G_SecureInspection  //Check on security...
		
		G_CountDiveInspPgs  //count pages
		
		If (vbInspectionLocked)
			//disable entry if inspection is locked
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "@_WP"; False:C215)
			
			OBJECT SET RGB COLORS:C628(*; "DE@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@"; <>Color_Not_Editable)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)
		Else 
			//otherwise make sure they are enterable   
			
			If (OBJECT Get enterable:C1067(*; "@_WP"))
			Else 
				OBJECT SET ENTERABLE:C238(*; "@_WP"; True:C214)
			End if 
			
			OBJECT SET ENTERABLE:C238(*; "DE@"; True:C214)
			
			OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)
			G_ReplyBtnCfg
		End if 
		
		//Oct-2001 : This is as a workaround to a feature of 4Dwrite areas
		//where they do a data change event after the validation and before
		//the onload
		C_BOOLEAN:C305(bDiveFormValid)
		bDiveFormValid:=False:C215
		
	: (Form event code:C388=On Validate:K2:3)
		
		INSP_UWSaveInsp
		
		//Make sure buttons and fields are left unlocked
		OBJECT SET ENTERABLE:C238(*; "DE@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		//Oct-2001 : This is as a workaround to a feature of 4Dwrite areas
		//where they do a data change event after the validation and before
		//the onload
		bDiveFormValid:=True:C214
		
	: (Form event code:C388=On Close Detail:K2:24)
		Case of 
			: (FORM Get current page:C276=2)
				//on elementssafety page
				G_Insp_ElmtArray_setup
				
		End case 
		
	: (Form event code:C388=On Resize:K2:27)
		INSP_RedrawSubForm_LB  //redraw listboxes in subforms in current tab
		
End case 