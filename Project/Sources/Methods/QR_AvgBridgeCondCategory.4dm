//%attributes = {"shared":true}
//Method: QR_AvgBridgeCondCategory
//Description
//  ` the bridge condition category based ◊BRG_CONDRANGE_aR
// Parameters
// $0 : $Category_txt
// $1 : $item58
// $2 : $item59
// $3 : $item60
// $4 : $item62
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/10/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_09
End if 
//
C_TEXT:C284($0; $Category_txt)
$Category_txt:=""
C_TEXT:C284($1; $2; $3; $4)
C_TEXT:C284($item58; $item59; $item60; $item62)
$item58:=$1
$item59:=$2
$item60:=$3
$item62:=$4

C_REAL:C285($avg_r)
C_LONGINT:C283($numvalid_L)

$numvalid_L:=fn_BridgeConditionAvg(->$avg_r; $item58; $item59; $item60; $item62)

If (($numvalid_L>0) & (Size of array:C274(<>BRG_CONDRANGE_aR)=Size of array:C274(<>BRG_CONDRANGE_atxt)))
	C_LONGINT:C283($loop_L)
	$Category_txt:=<>BRG_CONDRANGE_atxt{Size of array:C274(<>BRG_CONDRANGE_aR)}
	
	For ($loop_L; Size of array:C274(<>BRG_CONDRANGE_aR); 1; -1)
		
		If ($avg_r<<>BRG_CONDRANGE_aR{$loop_L})
			$Category_txt:=<>BRG_CONDRANGE_atxt{$loop_L}
		End if 
		
	End for 
End if 

$0:=$Category_txt+"-"+String:C10($avg_r; "####.###")

//End QR_BridgeCondCategory