//%attributes = {"invisible":true}
//Method: f_PadString
//Description
//  ` Pad a string up to a length
// Parameters
// $0 : $Res_txt
// $1 : $Inp_txt
// $2 : $PadLen_L
// $3 : $Append_b (Optional - assumed true = Append; False = Pre
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/04/12, 15:39:45
	// ----------------------------------------------------
	//Created : 
	Mods_2012_05
End if 
//
C_TEXT:C284($0; $Res_txt)
C_TEXT:C284($1; $Inp_txt; $Pad_txt)
C_LONGINT:C283($2; $PadLen_L)
$Inp_txt:=$1
$PadLen_L:=$2
C_BOOLEAN:C305($Append_b)
$Append_b:=True:C214
If (Count parameters:C259>2)
	C_BOOLEAN:C305($3)
	$Append_b:=$3
End if 

$Res_txt:=$Inp_txt
If ($PadLen_L>Length:C16($Inp_txt))
	$Pad_txt:=" "*($PadLen_L-Length:C16($Inp_txt))
	
	If ($Append_b)
		$Res_txt:=$Res_txt+$Pad_txt
	Else 
		$Res_txt:=$Pad_txt+$Res_txt
	End if 
	
End if 

$0:=$Res_txt
//End f_PadString