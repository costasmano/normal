If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/09/05, 16:41:19
	// ----------------------------------------------------
	// Method: Form Method: Config
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 10:45:07)
	Mods_2005_CM19
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(vUseHLists_B; vAllowDefault_B)
		If (vUseHLists_B)
			FORM GOTO PAGE:C247(1)
			C_LONGINT:C283($restrictPos_L; $i; $ItemRef_L; $SubList_HL)
			C_TEXT:C284($ItemTxt_txt)
			C_BOOLEAN:C305($vExpanded_B)
			//Contract source HL
			$restrictPos_L:=Count list items:C380(AllCategories_HL)
			For ($i; 1; Count list items:C380(AllCategories_HL))
				GET LIST ITEM:C378(AllCategories_HL; $i; $ItemRef_L; $ItemTxt_txt; $SubList_HL; $vExpanded_B)
				If (Is a list:C621($SubList_HL))
					SET LIST ITEM:C385(AllCategories_HL; $ItemRef_L; $ItemTxt_txt; $ItemRef_L; $SubList_HL; False:C215)
					REDRAW:C174(AllCategories_HL)  // Command Replaced was o_REDRAW LIST 
					$restrictPos_L:=Count list items:C380(AllCategories_HL)
				End if 
			End for 
			SELECT LIST ITEMS BY POSITION:C381(AllCategories_HL; 1)
			If (vAllowDefault_B)
				OBJECT SET ENABLED:C1123(*; "ButtonSetToDefault"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET TITLE:C194(*; "ButtonSetToDefault"; "Defaults for "+[WorkHour_Config:104]AssignType:2)
			Else 
				OBJECT SET ENABLED:C1123(*; "ButtonSetToDefault"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				If ([Contract_Assignment_Maintenance:101]ProjectType:36#"")
					OBJECT SET TITLE:C194(*; "ButtonSetToDefault"; "No Defaults for "+[Contract_Assignment_Maintenance:101]ProjectType:36)
				Else 
					OBJECT SET TITLE:C194(*; "ButtonSetToDefault"; "No Project Type Assigned")
				End if 
				OBJECT SET FONT STYLE:C166(*; "ButtonSetToDefault"; Plain:K14:1+Italic:K14:3)
			End if 
			If ((User in group:C338(Current user:C182; "BridgeMaintenance")) | (Current user:C182="Designer"))
				OBJECT SET VISIBLE:C603(*; "ButtonSaveDefaults@"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "ButtonSaveDefaults@"; False:C215)
			End if 
			
		Else 
			FORM GOTO PAGE:C247(2)
		End if 
		
	: (Form event code:C388=On Resize:K2:27)
		C_LONGINT:C283($Box1L; $Box1R; $Box2L; $Box2R; $DirBtnL; $WinL; $WinR; $WinT; $WinB; $BoxT; $BoxB; $WinW; $Diff)
		GET WINDOW RECT:C443($WinL; $WinT; $WinR; $WinB)
		$WinW:=$WinR-$WinL
		OBJECT GET COORDINATES:C663(*; "AllCategories"; $Box1L; $BoxT; $Box1R; $BoxB)
		OBJECT GET COORDINATES:C663(*; "CurrCategories"; $Box2L; $BoxT; $Box2R; $BoxB)
		$Diff:=($WinW-($Box2R+$Box1L)/2)
		OBJECT MOVE:C664(*; "AllCategories@"; 0; 0; $Diff; 0)
		OBJECT MOVE:C664(*; "CurrCategories@"; $Diff; 0; $Diff; 0)
		OBJECT MOVE:C664(*; "Button@"; $Diff; 0; 0; 0)
		OBJECT MOVE:C664(*; "LabelCurr@"; $Diff; 0; 0; 0)
End case 