
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 08/13/15, 13:20:51
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].Input.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_08_bug
	// Added code to allow change to mile marker/ kilo point on 
	//Modified by: administrator (8/13/15 12:16:35)
End if 
If (False:C215)
	ARRAY TEXT:C222($ToolsText_atxt; 4)
	ARRAY TEXT:C222($ToolsParams_atxt; 4)
	$ToolsText_atxt{1}:="Choose Edit Option...."
	$ToolsText_atxt{2}:="Edit Mile/Kilo Point"
	$ToolsParams_atxt{2}:="Mile"
	$ToolsText_atxt{3}:="Edit Inventory Structure Number"
	$ToolsParams_atxt{3}:="INV"
	$ToolsText_atxt{4}:="Lock Mile/Kilo Point"
	$ToolsParams_atxt{4}:="LOCK"
	C_TEXT:C284($menu_txt)
	$menu_txt:=ut_ArrayToDynamicMenu(->$ToolsText_atxt; ->$ToolsParams_atxt; "*")
	C_TEXT:C284($UserChoise_txt)
	$UserChoise_txt:=Dynamic pop up menu:C1006($menu_txt)
	Case of 
		: ($UserChoise_txt="Mile")
			LSS_Edit_MilePoint("EDIT")
		: ($UserChoise_txt="LOCK")
			LSS_Edit_MilePoint("LOCK")
		: ($UserChoise_txt="INV")
			LSS_Edit_Inv_SIN
	End case 
	RELEASE MENU:C978($menu_txt)
Else 
	FM_SaveInventoryInput
	
	LSS_Edit_Inv_SIN
End if 
//End Object Method: [LSS_Inventory].Input.Button