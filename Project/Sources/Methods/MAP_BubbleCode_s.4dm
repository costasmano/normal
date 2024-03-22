//%attributes = {"invisible":true}
//Method: MAP_BubbleCode_s
//Description
//  ` return a two digit bubble code from a number. code based on 0-9,a-z,A-Z
// Parameters
// $0 : $bubbleCode_s
// $1 : $Index_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/19/15, 16:43:26
	// ----------------------------------------------------
	//Created : 
	Mods_2015_05
	C_TEXT:C284(MAP_BubbleCode_s; $0)  // was length of 2
	C_LONGINT:C283(MAP_BubbleCode_s; $1)
End if 
//
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283($1)
ARRAY TEXT:C222($mydigits; 62)  //Command Replaced was o_ARRAY string length was 1
C_LONGINT:C283($loop_L)
For ($loop_L; 1; 10)
	$mydigits{$loop_L}:=String:C10($loop_L-1)
End for 
For ($loop_L; 11; 36)
	$mydigits{$loop_L}:=Char:C90(Character code:C91("a")+$loop_L-11)
End for 
For ($loop_L; 37; 62)
	$mydigits{$loop_L}:=Char:C90(Character code:C91("A")+$loop_L-37)
End for 
//$mydigits{63}:=" "
C_LONGINT:C283($int_L; $Remainder_L; $num_L)
C_TEXT:C284($code_txt)
$num_L:=$1-1
$int_L:=Int:C8($num_L/62)
$Remainder_L:=Mod:C98($num_L; 62)
$loop_L:=2
$code_txt:="00"
Repeat 
	$code_txt[[$loop_L]]:=$mydigits{$Remainder_L+1}
	$Remainder_L:=Mod:C98($int_L; 62)
	$int_L:=Int:C8($int_L/62)
	$loop_L:=$loop_L-1
Until (($int_L=0) | ($loop_L<1))
If ($loop_L>0)
	$code_txt[[$loop_L]]:=$mydigits{$Remainder_L+1}
End if 
//$0:=$mydigits{(($1-1)\62)+1}+$mydigits{(($1-1)%62)}
$0:=$code_txt
//End MAP_BubbleCode_s
