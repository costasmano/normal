//Method: [LSS_Inventory];"ListBoxOutput".Tools
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/04/18, 17:31:00
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
	// Modified by: Costas Manousakis-(Designer)-(12/4/18 16:48:10)
	Mods_2018_12_bug
	//  `obj set vis = false when not permitted.
	// Modified by: Costas Manousakis-(Designer)-(2024-03-13 17:09:19)
	Mods_2024_LSS_1
	//  `on form enabled On load event for button
End if 
//

Case of 
	: (Form event code:C388=On Load:K2:1)
		If ((User in group:C338(Current user:C182; "Design Access Group")) | (GRP_UserInGroup("LSS_MassEditAccess")=1))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		//Edit owner for selected records 
		C_TEXT:C284($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
		$func_txt:="LSS_TOOLS"
		$Title_txt:="Select a Tool"
		$Okbtn_txt:="Execute"
		$IconName_txt:="OSX Toolset"
		TMPL_Do_Template_Choise($func_txt; $Title_txt; $Okbtn_txt; $IconName_txt)
		
End case 

//End [LSS_Inventory];"ListBoxOutput".Tools