//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/30/07, 15:55:32
	// ----------------------------------------------------
	// Method: PRJ_DisplayDesignContr
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CJMv2  //04/30/07, 12:00:48`Fix compiler errors
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
End if 
If (Not:C34(Is compiled mode:C492))
	Compiler_PRJ
	Compiler_LSTS
	Compiler_SQL
End if 
UpdatWindArray(""; Current process:C322)
READ ONLY:C145(*)
READ WRITE:C146([PRJ_DesignContracts:123])
ALL RECORDS:C47([PRJ_DesignContracts:123])
FORM SET INPUT:C55([PRJ_DesignContracts:123]; "Input")
FORM SET OUTPUT:C54([PRJ_DesignContracts:123]; "Output")
C_LONGINT:C283($win_L; $Width_l; $Height_l; $Width_i_l; $win)

C_BOOLEAN:C305($useLB_B)
$useLB_B:=ut_UseListBox(Current method name:C684)
C_TEXT:C284($Form_txt)
If ($useLB_B)
	$Form_txt:="Output_LB"
Else 
	$Form_txt:="Output"
End if 
PRJ_WinTitle:="Design Contracts"
FORM GET PROPERTIES:C674([PRJ_DesignContracts:123]; $Form_txt; $Width_l; $Height_l)
$win_L:=ut_OpenNewWindow($Width_l; 600; 1; Plain form window:K39:10; PRJ_WinTitle+"["+String:C10(Records in selection:C76([PRJ_ProjectDetails:115]))+"]"; "ut_CloseCancel")

Compiler_FieldVariables
SET MENU BAR:C67(3)
If ($useLB_B)
	DIALOG:C40([PRJ_DesignContracts:123]; $Form_txt)
Else 
	MODIFY SELECTION:C204([PRJ_DesignContracts:123]; *)
End if 
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154
//End PRJ_DisplayProjects