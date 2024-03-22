//%attributes = {"shared":true}
//Method: QR_Appraisal_LTE4_L
//Description
//  ` If any of the ratings are lte 4
// Parameters
// $0 : $LTE4_L (0 : not ; 1 : Yes ; -1 : some error)
// $1 : $i58_txt
// $2 : $i59_txt
// $3 : $i60_txt
// $4 : $i62_txt
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
C_LONGINT:C283($0; $LTE4_L)

C_TEXT:C284($i58_txt; $1; $i59_txt; $2; $i60_txt; $3; $i62_txt; $4)

$i58_txt:=$1
$i59_txt:=$2
$i60_txt:=$3
$i62_txt:=$4

$LTE4_L:=-1

C_BOOLEAN:C305($LTE4_b)

If (bIsNumeric($i58_txt) | bIsNumeric($i59_txt) | bIsNumeric($i60_txt) | bIsNumeric($i62_txt))
	
	$LTE4_L:=0
	$LTE4_b:=False:C215
	$LTE4_b:=$LTE4_b | ((Num:C11($i58_txt)<=4) & bIsNumeric($i58_txt))
	$LTE4_b:=$LTE4_b | ((Num:C11($i59_txt)<=4) & bIsNumeric($i59_txt))
	$LTE4_b:=$LTE4_b | ((Num:C11($i60_txt)<=4) & bIsNumeric($i60_txt))
	$LTE4_b:=$LTE4_b | ((Num:C11($i62_txt)<=4) & bIsNumeric($i62_txt))
	
	If ($LTE4_b)
		$LTE4_L:=1
	End if 
	
End if 

$0:=$LTE4_L
//End QR_Appraisal_LTE4_L