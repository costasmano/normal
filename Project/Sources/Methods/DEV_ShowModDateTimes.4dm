//%attributes = {"invisible":true}
//Method: DEV_ShowModDateTimes
//Description
// show all methods by mod date and time - allow opening the selected one
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/17/17, 14:35:39
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
	// Modified by: Costas Manousakis-(Designer)-(8/28/17 15:53:40)
	Mods_2017_08
	//  `use String(date;..;time) instead of ut_createtimestamp
	// Modified by: Costas Manousakis-(Designer)-(9/8/17 10:28:20)
	Mods_2017_09_bug
	//  `add ut_CloseCancel so that the close window red button is enabled
	
	// Modified by: Costas Manousakis-(Designer)-(9/15/17 16:51:28)
	Mods_2017_09
	//  `added optional parameter so it launches in own process when called from a macro
	
	C_TEXT:C284(DEV_ShowModDateTimes; $1)
	
End if 
//

If (Count parameters:C259=0)
	C_LONGINT:C283($LPid_L)
	$LPid_L:=LSpawnProcess(Current method name:C684; <>LStackSize; "MethodList"; True:C214; False:C215; "RUN")
Else 
	C_TEXT:C284($1)
	DEV_BuildModDateName
	
	C_LONGINT:C283($W; $H)
	FORM GET PROPERTIES:C674("MethodsList"; $w; $H)
	C_TEXT:C284(1_txt; $StrucName_txt; $StructPath_txt)
	$StrucName_txt:=Structure file:C489
	
	If (Position:C15(Folder separator:K24:12; $StrucName_txt)>0)
		$StructPath_txt:=GetPath($StrucName_txt)
		$StrucName_txt:=Replace string:C233($StrucName_txt; $StructPath_txt; "")
		$StrucName_txt:="Local "+$StrucName_txt
	Else 
		$StrucName_txt:="Client "+$StrucName_txt
	End if 
	
	1_txt:="Mod DateTime - Methodname"  //  header title for the listbox
	CENTER_WINDOW($W; $H; -(Plain form window:K39:10+Texture appearance:K34:17); $StrucName_txt+" Methods"; "ut_CloseCancel")
	DIALOG:C40("MethodsList")
	CLOSE WINDOW:C154
	
End if 

//End DEV_ShowModDateTimes