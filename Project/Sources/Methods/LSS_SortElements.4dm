//%attributes = {"invisible":true}
//Method: LSS_SortElements
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/20/18, 17:16:19
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12  //add [LSS_ElementInspection] query and report
	//Modified by: Chuck Miller (1/24/19 11:42:45)
End if 
//

C_TEXT:C284($0)
C_TEXT:C284($structure_txt)
C_DATE:C307($Insp_d)
C_LONGINT:C283($Loc_L; $InsPos_L; $InvPos_L)
$Loc_L:=Find in array:C230(v_162_001_aL; [LSS_ElementInspection:163]LSS_ElementId_L:2)
$InsPos_L:=Find in array:C230(v_164_001_atxt; [LSS_ElementInspection:163]LSS_InspectionId_s:3)
If ($InsPos_L>0)
	$InvPos_L:=Find in array:C230(v_165_001_atxt; v_164_002_atxt{$InsPos_L})
	//$Insp_d:=v_164_004_ad{$InsPos_L}
	If ($InvPos_L>0)
		$structure_txt:=v_165_006_atxt{$InvPos_L}
	End if 
End if 
//+String($Insp_d;ISO date)
If ($Loc_L>0)
	$0:=$structure_txt+v_162_002_atxt{Find in array:C230(v_162_001_aL; [LSS_ElementInspection:163]LSS_ElementId_L:2)}
Else 
	$0:=$structure_txt
End if 
//End LSS_SortElements