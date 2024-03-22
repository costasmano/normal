//%attributes = {"invisible":true}
//Method: NTI_NavigateInput_OM
//Description
//
// Parameters
// $1 : $navCommand_txt (First, previous, next, last)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 10:47:59
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_TEXT:C284(NTI_NavigateInput_OM; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(11/16/16 11:12:04)
	Mods_2016_11
	//  `Use on Load event instead of mouse enter/leave Handle new method of diplaying the help tip with new kbd shortcuts
	// Modified by: Costas Manousakis-(Designer)-(1/22/18 17:26:03)
	Mods_2018_01
	//  `if Record was not saved don't navigate away
	// Modified by: Costas Manousakis-(Designer)-(9/21/21 09:55:20)
	Mods_2021_09
	//  `When moving to other record don't call dialog/modify record, call the form method and WP area method with On Load parameter
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
		
	: (Form event code:C388=On Clicked:K2:4)
		C_BOOLEAN:C305($doNav_b)
		$doNav_b:=True:C214
		If ((Not:C34(NTI_ModifiedRecord(Current form table:C627))) | Read only state:C362(Current form table:C627->))
			//no changes - go ahead and move
			
		Else 
			C_LONGINT:C283($Option_L)
			$Option_L:=ut_3Option_Confirm("Changes have been made to the current NTE record! Save changes and Continue, Abort changes and Continue, Cancel "; "Save"; "Abort"; "Cancel")
			Case of 
				: ($Option_L=1)
					If (NTI_ELEMINP_SAVE(Current form table:C627))
					Else   //record was not saved properly 
						$doNav_b:=False:C215
					End if 
				: ($Option_L=2)
					//if we do nothing here, the changes will be lost
				: ($Option_L=3)
					$doNav_b:=False:C215
			End case 
		End if 
		
		If ($doNav_b)
			Case of 
				: ($navCommand_txt="First")
					FIRST RECORD:C50(Current form table:C627->)
				: ($navCommand_txt="Previous")
					PREVIOUS RECORD:C110(Current form table:C627->)
				: ($navCommand_txt="Next")
					NEXT RECORD:C51(Current form table:C627->)
				: ($navCommand_txt="Last")
					LAST RECORD:C200(Current form table:C627->)
			End case 
			NTI_ELEMINP_TIN_FM(On Load:K2:1)
			INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE ElementComments_WP"; "fieldptr"; ->[NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9; "formEvent"; On Load:K2:1; "changeStack"; PON_ChangeStackLvl_L))
			
			//CANCEL
			//If (Read only state(Current form table->))
			//DIALOG(Current form table->;"Input")
			//Else 
			//MODIFY RECORD(Current form table->)
			//End if 
		End if 
		
End case 

//End NTI_NavigateInput_OM