//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_MoveToSelected
// User name (OS): cjmiller
// Date and time: 04/07/06, 16:35:43
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v5303  //r006 `11/06/07, 11:42:52
End if 
C_POINTER:C301($SelectedArray_ptr; $SelectedRecordNumberArray_ptr; $1; $2)
$SelectedArray_ptr:=$1
$SelectedRecordNumberArray_ptr:=$2
C_LONGINT:C283($Size_l)
$Size_l:=Size of array:C274($SelectedArray_ptr->)+1
INSERT IN ARRAY:C227($SelectedArray_ptr->; $Size_l; 1)
INSERT IN ARRAY:C227($SelectedRecordNumberArray_ptr->; $Size_l; 1)

$SelectedArray_ptr->{$Size_l}:=PRJ_AvailableBins_atxt{PRJ_AvailableBins_atxt}
$SelectedRecordNumberArray_ptr->{$Size_l}:=PRJ_AvailableBinRecordNos_al{PRJ_AvailableBins_atxt}

DELETE FROM ARRAY:C228(PRJ_AvailableBins_atxt; PRJ_AvailableBins_atxt; 1)
DELETE FROM ARRAY:C228(PRJ_AvailableBinRecordNos_al; PRJ_AvailableBins_atxt; 1)
OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
If (Size of array:C274(PRJ_AvailableBins_atxt)=0)
	OBJECT SET VISIBLE:C603(*; "Include@"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "Include@"; True:C214)
End if 
//End PRJ_MoveToSelected