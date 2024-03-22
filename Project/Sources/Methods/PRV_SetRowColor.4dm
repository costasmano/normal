//%attributes = {"invisible":true}
//Method: PRV_SetRowColor
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/01/13, 08:52:05
	// ----------------------------------------------------
	//Created : 
	Mods_2013_02
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
//
C_TEXT:C284($ProjColor_txt)

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$ProjColor_txt:=$1
Else 
	$ProjColor_txt:=[Contract_Assignment_Maintenance:101]ProjectColor_s:75
End if 

C_LONGINT:C283($0; $RowColor_L)

$RowColor_L:=16777215
C_LONGINT:C283($ColorIndx_L)
$ColorIndx_L:=Find in array:C230(PRV_ProjectColors_atxt; [Contract_Assignment_Maintenance:101]ProjectColor_s:75)

If ($ColorIndx_L>0)
	$RowColor_L:=PRV_ProjectColors_aL{$ColorIndx_L}
End if 

$0:=$RowColor_L
//End PRV_SetRowColor