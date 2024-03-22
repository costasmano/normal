//%attributes = {"invisible":true}
//Method: PON_NavigateInput_OM
//Description
//
// Parameters
// $1 : $navCommand_txt ("First;Previous;Next;Last)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/03/15, 16:10:42
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
	// Modified by: Costas Manousakis-(Designer)-(11/14/16 15:34:12)
	Mods_2016_11
	//  `Handle new method of diplaying the help tip with new kbd shortcuts
	// Modified by: Costas Manousakis-(Designer)-(11/17/16 15:07:01)
	Mods_2016_11
	//  `use on load event to set the keyboard shortcut and the help tip
	// Modified by: Costas Manousakis-(Designer)-(2021-09-21T00:00:00 13:44:40)
	Mods_2021_09
	//  `instead of loading a new form (dialog or modify record) , run the on Load code of the form method
End if 
//
C_TEXT:C284($1)
C_TEXT:C284($navCommand_txt)
$navCommand_txt:=$1
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283($keyMask_L)
		C_TEXT:C284($Key_txt; $Tip_txt; $RecordName_txt)
		$RecordName_txt:="Element"
		Case of 
			: ($navCommand_txt="First")
				$Tip_txt:="First "+$RecordName_txt+" (Cmd-PgUp)"
				$Key_txt:=Shortcut with Page up:K75:25
				$keyMask_L:=Command key mask:K16:1
				
			: ($navCommand_txt="Previous")
				$Tip_txt:="Previous "+$RecordName_txt+" (PgUp)"
				$Key_txt:=Shortcut with Page up:K75:25
				$keyMask_L:=0
				
			: ($navCommand_txt="Next")
				$Tip_txt:="Next "+$RecordName_txt+" (PgDn)"
				$Key_txt:=Shortcut with Page down:K75:26
				$keyMask_L:=0
				
			: ($navCommand_txt="Last")
				$Tip_txt:="Last "+$RecordName_txt+" (Cmd-PgDn)"
				$Key_txt:=Shortcut with Page down:K75:26
				$keyMask_L:=Command key mask:K16:1
		End case 
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "(Cmd-"; "(CTRL-")
		End if 
		
		OBJECT SET SHORTCUT:C1185(Self:C308->; $Key_txt; $keyMask_L)
		OBJECT SET HELP TIP:C1181(Self:C308->; $Tip_txt)
		
	: (Form event code:C388=On Mouse Enter:K2:33) | (Form event code:C388=On Mouse Leave:K2:34)
		C_TEXT:C284($Tip_txt)
		
		Case of 
			: ($navCommand_txt="First")
				$Tip_txt:="First Element (Cmd-PgUp)"
			: ($navCommand_txt="Previous")
				$Tip_txt:="Previous Element (PgUp)"
			: ($navCommand_txt="Next")
				$Tip_txt:="Next Element (PgDn)"
			: ($navCommand_txt="Last")
				$Tip_txt:="Last Element (Cmd-PgDn)"
		End case 
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "(Cmd-"; "(CTRL-")
		End if 
		
		ut_GenericHelp_OM($Tip_txt)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_BOOLEAN:C305($doNav_b)
		$doNav_b:=True:C214
		If (Not:C34(Modified record:C314([PON_ELEM_INSP:179])))
			//no changes - go ahead and move
		Else 
			C_LONGINT:C283($Option_L)
			$Option_L:=ut_3Option_Confirm("Changes have been made to the current NBE record! Save changes and Continue, Abort changes and Continue, Cancel "; "Save"; "Abort"; "Cancel")
			Case of 
				: ($Option_L=1)
					PON_ELEMINP_SAVE
				: ($Option_L=2)
					//if we do nothing here, the changes will be lost
				: ($Option_L=3)
					$doNav_b:=False:C215
			End case 
		End if 
		
		If ($doNav_b)
			Case of 
				: ($navCommand_txt="First")
					FIRST RECORD:C50([PON_ELEM_INSP:179])
				: ($navCommand_txt="Previous")
					PREVIOUS RECORD:C110([PON_ELEM_INSP:179])
				: ($navCommand_txt="Next")
					NEXT RECORD:C51([PON_ELEM_INSP:179])
				: ($navCommand_txt="Last")
					LAST RECORD:C200([PON_ELEM_INSP:179])
			End case 
			If (False:C215)
				CANCEL:C270
				If (Read only state:C362([PON_ELEM_INSP:179]))
					DIALOG:C40([PON_ELEM_INSP:179]; "Input")
				Else 
					MODIFY RECORD:C57([PON_ELEM_INSP:179])
				End if 
				
			Else 
				//run the form method on load event
				PON_ELEMINP_FM(On Load:K2:1)
			End if 
		End if 
		
End case 

//End PON_NavigateInput_OM