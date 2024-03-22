//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/13/10, 15:04:35
	// ----------------------------------------------------
	// Method: fn_BridgeConditionAvg
	// Description
	// Get the average of a series of NBI coding Items 
	// 
	// Parameters
	// $0 : $NumValidItems (numeric)
	// $1 : $Avg_ptr
	// ${2} : $Item_s{s} 
	// ----------------------------------------------------
	
	Mods_2010_04
End if 
C_LONGINT:C283($0; $NumValidItems_L)
C_REAL:C285($Avg_r)
C_POINTER:C301($1; $Avg_ptr)
C_TEXT:C284(${2})  // Command Replaced was o_C_STRING length was 2
$Avg_ptr:=$1
C_LONGINT:C283($ItemSum_L; $Loop_L; $NumPars_L)
$Avg_r:=0
$NumPars_L:=Count parameters:C259
$ItemSum_L:=0
$NumValidItems_L:=0
For ($Loop_L; 2; $NumPars_L)
	If (bIsNumeric(${$Loop_L}))
		$ItemSum_L:=$ItemSum_L+Num:C11(${$Loop_L})
		$NumValidItems_L:=$NumValidItems_L+1
	End if 
End for 
If ($NumValidItems_L>0)
	$Avg_r:=$ItemSum_L/$NumValidItems_L
End if 
$Avg_ptr->:=$Avg_r
$0:=$NumValidItems_L
