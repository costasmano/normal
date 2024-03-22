//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_MoveToAvailable
// User name (OS): cjmiller
// Date and time: 03/23/06, 13:51:38
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v5303  //r006 `11/06/07, 12:06:15
End if 
C_POINTER:C301($SelectedArray_ptr; $SelectedRecordNumberArray_ptr; $1; $2)
$SelectedArray_ptr:=$1
$SelectedRecordNumberArray_ptr:=$2
C_LONGINT:C283($Position_l; $3)
$Position_l:=$3
If ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34=Substring:C12($SelectedArray_ptr->{$Position_l}; 1; 3))
	ALERT:C41("You may not move the primary BIN to unselected")
Else 
	C_LONGINT:C283($Size_l)
	$Size_l:=Size of array:C274(PRJ_AvailableBins_atxt)+1
	INSERT IN ARRAY:C227(PRJ_AvailableBins_atxt; $Size_l; 1)
	INSERT IN ARRAY:C227(PRJ_AvailableBinRecordNos_al; $Size_l; 1)
	
	PRJ_AvailableBins_atxt{$Size_l}:=$SelectedArray_ptr->{$Position_l}
	PRJ_AvailableBinRecordNos_al{$Size_l}:=$SelectedRecordNumberArray_ptr->{$Position_l}
	
	DELETE FROM ARRAY:C228($SelectedArray_ptr->; $Position_l; 1)
	DELETE FROM ARRAY:C228($SelectedRecordNumberArray_ptr->; $Position_l; 1)
	If (Size of array:C274(PRJ_AvailableBins_atxt)=0)
		OBJECT SET VISIBLE:C603(*; "Include@"; False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*; "Include@"; True:C214)
	End if 
End if 
//End PRJ_MoveToAvailable