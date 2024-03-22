//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/07/06, 11:21:19
	// ----------------------------------------------------
	// Method: QR_NBIItemAvg
	// Description
	// Return the average of NBI coding Items passed.
	// Will ignore an item that is coded not numeric.
	// Parameters
	// $0 : Average (real)
	// $($i) : Item values (string(2))
	// ----------------------------------------------------
	
End if 
C_REAL:C285($0; $Average_r)
C_TEXT:C284(${1})  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283($ParamCount_L; $i)
C_REAL:C285($Sum_r; $NumValidP_r; $ParamValue_r)
C_TEXT:C284($CurrParam_s)  // Command Replaced was o_C_STRING length was 1
$Average_r:=-1
$ParamCount_L:=Count parameters:C259
If ($ParamCount_L>0)
	$Sum_r:=0
	$NumValidP_r:=0
	For ($i; 1; $ParamCount_L)
		$CurrParam_s:=Substring:C12(${$i}; 1; 1)
		If (Position:C15($CurrParam_s; ";0;1;2;3;4;5;6;7;8;9;")>0)
			$NumValidP_r:=$NumValidP_r+1
			$Sum_r:=$Sum_r+Num:C11($CurrParam_s)
		End if 
		
	End for 
	If ($NumValidP_r>0)
		$Average_r:=$Sum_r/$NumValidP_r
	End if 
	
End if 
$0:=$Average_r