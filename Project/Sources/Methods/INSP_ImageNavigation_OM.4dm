//%attributes = {"invisible":true}
//Method: INSP_ImageNavigation_OM
//Description
// Use in the record navigation buttons of standard Photos input form
// Parameters
// $1 : $HelpMessage_txt
// $2 : $KbdShortcut_txt - mac os shortcut : if Cmd is used will be replaced with CTRL on Windows
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/14/16, 14:41:51
	// ----------------------------------------------------
	//Created : 
	Mods_2016_11
	Mods_2019_04  //change to Listboxes on inspection forms
	//changed first/prev/next/last buttons to no action
	C_TEXT:C284(INSP_ImageNavigation_OM; $1)  //
	C_TEXT:C284(INSP_ImageNavigation_OM; $2)  //
	
	// Modified by: Costas Manousakis-(Designer)-(4/22/21 10:15:30)
	Mods_2021_04
	//  `Enable the navigation from this method. Automatic action was removed from the navigation buttons on the form
	// Modified by: Costas Manousakis-(Designer)-(2021-09-20 13:48:42)
	Mods_2021_09
	//  `instead of loading a new form (dialog or modify record) , run the on Load code of the form method
	// Modified by: Costas Manousakis-(Designer)-(2022-01-05T00:00:00 16:18:10)
	Mods_2022_01
	//  `do not pass the "SAVE" param to INSP_SavePhoto method, that caused the form to go back to list by issuing an ACCEPT 
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
		ut_GenericHelp_OM($Tip_txt)
		
	End if 
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (Modified record:C314([Standard Photos:36]))
		INSP_SavePhoto  //("SAVE")
		SAVE RECORD:C53([Standard Photos:36])
	End if 
	C_LONGINT:C283($LSS_SelectedRow_L)
	Case of 
		: ($1="First Image")
			$LSS_SelectedRow_L:=1
		: ($1="Previous Image")
			$LSS_SelectedRow_L:=Selected record number:C246([Standard Photos:36])-1
		: ($1="Next Image")
			$LSS_SelectedRow_L:=Selected record number:C246([Standard Photos:36])+1
		: ($1="Last Image")
			$LSS_SelectedRow_L:=Records in selection:C76([Standard Photos:36])
	End case 
	GOTO SELECTED RECORD:C245([Standard Photos:36]; $LSS_SelectedRow_L)
	FM_StandardPhotosInput(On Load:K2:1)
	//CANCEL  // need to cancel current form
	//If (Read only state([Standard Photos]))
	//DIALOG([Standard Photos];"Standard Photos")
	//Else 
	//MODIFY RECORD([Standard Photos])
	//End if 
	
End if 
//End INSP_ImageNavigation