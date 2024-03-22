//%attributes = {"invisible":true}
//Method: PON_INSPKEY2INSPID
//Description
// convert an INSPKEY to a longint
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 16:36:23
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 

C_LONGINT:C283($0)
C_TEXT:C284($1)

C_TEXT:C284($Inspkey_txt; $Part_txt)
C_LONGINT:C283($inspid_L; $exp_L; $loop_L)
$Inspkey_txt:=$1

$inspid_L:=0
$exp_L:=0
For ($loop_L; Length:C16($Inspkey_txt); 1; -1)
	$inspid_L:=$inspid_L+((Character code:C91(Substring:C12($Inspkey_txt; $loop_L; 1))-Character code:C91("A"))*(26^$exp_L))
	$exp_L:=$exp_L+1
End for 

$0:=$inspid_L
//End PON_INSPKEY2INSPID