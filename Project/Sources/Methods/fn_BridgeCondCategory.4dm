//%attributes = {}
//Method: fn_BridgeCondCategory
//Description
//  ` The bridge cond category based on ◊BRG_CONDRANGE_atxt
// Parameters
// $0 : $Category_txt
// $1 : $avg_r
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

C_REAL:C285($avg_r; $1)

$avg_r:=$1

If (Size of array:C274(<>BRG_CONDRANGE_aR)=Size of array:C274(<>BRG_CONDRANGE_atxt))
	C_LONGINT:C283($loop_L)
	$Category_txt:=<>BRG_CONDRANGE_atxt{Size of array:C274(<>BRG_CONDRANGE_aR)}
	
	For ($loop_L; Size of array:C274(<>BRG_CONDRANGE_aR); 1; -1)
		
		If ($avg_r<<>BRG_CONDRANGE_aR{$loop_L})
			$Category_txt:=<>BRG_CONDRANGE_atxt{$loop_L}
		End if 
		
	End for 
End if 

$0:=$Category_txt
//End fn_BridgeCondCategory