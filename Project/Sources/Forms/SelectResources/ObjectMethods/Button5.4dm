//Method: SelectResources.Button5
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 10/03/19, 17:10:59
	// ----------------------------------------------------
	//Created : 
	Mods_2019_10
End if 
//
ARRAY TEXT:C222($LBGeneric_atxt; 0)
COPY ARRAY:C226(LBGeneric_atxt; $LBGeneric_atxt)
C_TEXT:C284($mainmenu_txt; $choise_txt)
SORT ARRAY:C229($LBGeneric_atxt; >)
$mainmenu_txt:=MENU_BuildMenuFromArrays(->$LBGeneric_atxt; ->$LBGeneric_atxt; Folder separator:K24:12)
C_LONGINT:C283($LOC_L)
//now test this
C_TEXT:C284($choise_txt)
$choise_txt:=Dynamic pop up menu:C1006($mainmenu_txt)
$LOC_L:=Find in array:C230(LBGeneric_atxt; $choise_txt)
If ($LOC_L>0)
	v_1_004_ab{$LOC_L}:=True:C214
	LISTBOX SELECT ROW:C912(*; "ResourceList"; $LOC_L)
	OBJECT SET SCROLL POSITION:C906(*; "ResourceList"; $LOC_L)
End if 
//End SelectResources.Button5X