Case of 
	: (Form event code:C388=On Load:K2:1)
		
		Case of 
			: (User in group:C338(Current user:C182; "Design Access Group"))
				//leave it on
			: (Not:C34(Read only state:C362([TIN_Inspections:184])))
				//also leave it on
			Else 
				OBJECT SET ENABLED:C1123(Self:C308->; False:C215)
		End case 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		C_LONGINT:C283($m_X; $M_y; $M_bthn)
		GET MOUSE:C468($m_X; $M_y; $M_bthn)
		OBJECT GET COORDINATES:C663(Self:C308->; $Ob_L; $ob_T; $ob_R; $ob_b)
		ARRAY TEXT:C222($menuOptions_atxt; 0)
		ARRAY TEXT:C222($MenuCmds_atxt; 0)
		
		If (Not:C34(Read only state:C362([TIN_Inspections:184])))
			APPEND TO ARRAY:C911($menuOptions_atxt; "Verify Inspection Completeness")
			APPEND TO ARRAY:C911($MenuCmds_atxt; "Verify")
		End if 
		If (User in group:C338(Current user:C182; "Design Access Group"))
			APPEND TO ARRAY:C911($menuOptions_atxt; "Inspection Info")
			APPEND TO ARRAY:C911($MenuCmds_atxt; "Info")
		End if 
		
		C_TEXT:C284($Menucmd_txt; $menu_txt)
		$menu_txt:=MENU_BuildMenuFromArrays(->$menuOptions_atxt; ->$MenuCmds_atxt; "\\")
		$Menucmd_txt:=Dynamic pop up menu:C1006($menu_txt; ""; $m_X; $M_y)
		RELEASE MENU:C978($menu_txt)
		Case of 
			: ($Menucmd_txt="Info")
				ALERT:C41("Current inspection ID = "+String:C10([TIN_Inspections:184]InspectionID:2))
				
			: ($Menucmd_txt="Verify")
				C_OBJECT:C1216($Message_obj)
				//start the bar
				C_OBJECT:C1216($progress_obj)
				$progress_obj:=ProgressNew("Verifying Inspection Completeness"; 1; False:C215; ""; 0)
				
				$Message_obj:=NTI_CheckInspComplete
				
				//quit progress
				Progress QUIT(OB Get:C1224($progress_obj; "progress"; Is longint:K8:6))
				
				ARRAY TEXT:C222($messageParts_atxt; 0)
				OB GET PROPERTY NAMES:C1232($Message_obj; $messageParts_atxt)
				If (Size of array:C274($messageParts_atxt)>0)
					NTI_DisplayInspChkMsgs($Message_obj; "Results of Inspection Completeness Check")
				Else 
					ALERT:C41("No Problems found in the Inspection report!")
				End if 
		End case 
		
End case 
