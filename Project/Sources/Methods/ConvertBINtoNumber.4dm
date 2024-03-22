//%attributes = {"invisible":true}
//Method: ConvertBINtoNumber
//Description
// calculate a number from a BIN
// Parameters
// $0 : $BIN_L
// $1 : $BIN_s
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/06/15, 16:05:45
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
C_LONGINT:C283($0; $BIN_L)
C_TEXT:C284($1; $BIN_s)  // Command Replaced was o_C_STRING length was 3
$BIN_s:=$1
C_TEXT:C284($BIN_Chars)  // Command Replaced was o_C_STRING length was 32
$BIN_Chars:="0123456789ABCDEFGHJKLMNPQRTUVWXY"

$BIN_L:=0
C_LONGINT:C283($loop_L; $exp_L; $C_index_L)
$exp_L:=0
For ($loop_L; Length:C16($BIN_s); 1; -1)
	$C_index_L:=Position:C15(Substring:C12($BIN_s; $loop_L; 1); $BIN_Chars)
	If ($C_index_L>0)
		$BIN_L:=$BIN_L+(($C_index_L-1)*(32^$exp_L))
		$exp_L:=$exp_L+1
	Else 
		$loop_L:=0
		$BIN_L:=0
	End if 
End for 

$0:=$BIN_L
//End ConvertBINtoNumber