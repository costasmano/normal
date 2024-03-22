//%attributes = {"invisible":true}
// Method: PON_INSPID2INSPKEY
// Description
// convert and inspection id _L to a BrM INSPKEY
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name(OS): Costas Manousakis
	// User(4D): Designer
	// Date and time: 12/27/14, 20:57:39
	// ----------------------------------------------------
	// Created :
	Mods_2014_12
End if 
// 
C_LONGINT:C283($1)
C_TEXT:C284($0)
C_TEXT:C284($Inspkey_txt)
$Inspkey_txt:="AAAA"
$InspID_L:=$1
C_LONGINT:C283($InspID_L; $Remainder_L; $Int_L; $loop_L)

$Int_L:=Int:C8($InspID_L/26)
$Remainder_L:=Mod:C98($InspID_L; 26)
$loop_L:=4
Repeat 
	$Inspkey_txt[[$loop_L]]:=Char:C90(Character code:C91("A")+$Remainder_L)
	$Remainder_L:=Mod:C98($Int_L; 26)
	$Int_L:=Int:C8($Int_L/26)
	$loop_L:=$loop_L-1
Until (($Int_L=0) | ($loop_L<1))
If ($loop_L>0)
	$Inspkey_txt[[$loop_L]]:=Char:C90(Character code:C91("A")+$Remainder_L)
Else 
	$Inspkey_txt:=">>>>"
End if 

$0:=$Inspkey_txt
// End PON_INSPID2INSPKEY