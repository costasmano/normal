//%attributes = {}
//Method: QR_LSS_ElementDescr
//Description
// Can be used in a quick report to get the element description
// Parameters
// $0 : ElementDecription
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/21/20, 15:33:57
	// ----------------------------------------------------
	//Created : 
	Mods_2020_02
	
	C_TEXT:C284(QR_LSS_ElementDescr; $0)
End if 
//

C_TEXT:C284($0; $ElemDescr)
$ElemDescr:=""
If ([LSS_ElementInspection:163]LSS_Description_txt:7#"")
	$ElemDescr:=[LSS_ElementInspection:163]LSS_Description_txt:7
Else 
	LSS_SetUpArraysforElements
	C_LONGINT:C283($Loc_L)
	$Loc_L:=Find in array:C230(v_162_001_aL; [LSS_ElementInspection:163]LSS_ElementId_L:2)
	If ($Loc_L>0)
		$ElemDescr:=v_162_002_atxt{$Loc_L}
	End if 
	
End if 

$0:=$ElemDescr

//End QR_LSS_ElementDescr