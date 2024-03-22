//%attributes = {"invisible":true}
//Method: ArcSin
//Description
//  ` Get the arc sin in radians of an input value
// Parameters
// $0 : $Ret Radians
// $1 : $Inpvalue
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/08/12, 15:05:18
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//
C_REAL:C285($1; $Inp_r; $atanArg_r)
$Inp_r:=$1
$atanArg_r:=$Inp_r/(1+Square root:C539(1-($Inp_r*$Inp_r)))
C_REAL:C285($Ret_r; $0)
$Ret_r:=2*Arctan:C20($atanArg_r)
$0:=$Ret_r
//End ArcSin