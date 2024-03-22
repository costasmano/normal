//%attributes = {"invisible":true}
//Method: INSP_ElementNavigation_OM
//Description
// Use in the record navigation buttons of ElementSafety input form
// Parameters
// $1 : $HelpMessage_txt
// $2 : $KbdShortcut_txt - mac os shortcut : if Cmd is used will be replaced with CTRL on Windows
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/14/16, 15:11:16
	// ----------------------------------------------------
	//Created : 
	Mods_2016_11
	C_TEXT:C284(INSP_ElementNavigation_OM; $1)  //
	C_TEXT:C284(INSP_ElementNavigation_OM; $2)  //
	
	// Modified by: Costas Manousakis-(Designer)-(4/22/21 10:20:23)
	Mods_2021_04
	//  `Enable the navigation from this method. Also save record if modified.
	//  `Automatic action was removed from the navigation buttons on the form
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 10:09:50)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-12-29T00:00:00 17:26:00)
	Mods_2021_12_bug
	//  `call INSP_Comments_WP_OM with on losing focus
End if 
//
C_TEXT:C284($1)
C_TEXT:C284($Tip_txt; $KbdShortcut_txt; $modifier_txt)
$Tip_txt:=$1
$KbdShortcut_txt:=""
If (Count parameters:C259>1)
	If (Form event code:C388#On Clicked:K2:4)
		C_TEXT:C284($2)
		$KbdShortcut_txt:=$2
		Case of 
			: ($2="@Cmd@")
				If (<>PL_LPlatfrm=Mac OS:K25:2)
					$KbdShortcut_txt:=$2
				Else 
					$KbdShortcut_txt:=Replace string:C233($2; "Cmd"; "CTRL")
				End if 
			Else 
		End case 
		
		$Tip_txt:=$Tip_txt+" ("+$KbdShortcut_txt+")"
	End if 
End if 

ut_GenericHelp_OM($Tip_txt)

If (Form event code:C388=On Clicked:K2:4)
	
	//WRT_CheckLosingFocus (AreaElmComments;On Losing Focus)
	INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE ElementComments_WP"; "fieldptr"; ->[ElementsSafety:29]ElmComments:23; "formEvent"; On Losing Focus:K2:8; "changeStack"; 2))
	C_LONGINT:C283($LSS_SelectedRow_L)
	C_TEXT:C284($FormName_txt)
	
	$FormName_txt:=Current form name:C1298
	
	If (Modified record:C314([ElementsSafety:29]))
		
		INSP_ElmSft_Input_FM(On Validate:K2:3)
		SAVE RECORD:C53([ElementsSafety:29])
	End if 
	
	Case of 
		: ($1="First Element")
			$LSS_SelectedRow_L:=1
		: ($1="Previous Element")
			$LSS_SelectedRow_L:=Selected record number:C246([ElementsSafety:29])-1
		: ($1="Next Element")
			$LSS_SelectedRow_L:=Selected record number:C246([ElementsSafety:29])+1
		: ($1="Last Element")
			$LSS_SelectedRow_L:=Records in selection:C76([ElementsSafety:29])
	End case 
	GOTO SELECTED RECORD:C245([ElementsSafety:29]; $LSS_SelectedRow_L)
	INSP_ElmSft_Input_FM(On Load:K2:1)
	INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE ElementComments_WP"; "fieldptr"; ->[ElementsSafety:29]ElmComments:23; "formEvent"; On Load:K2:1; "changeStack"; 2))
	
End if 

//End INSP_ElementNavigation_OM