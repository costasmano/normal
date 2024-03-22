//%attributes = {"invisible":true}
//Method: Dev_buildCaseStatements
//Description
// build case statement from data on clipboard
// Clipboard
// label1 \t valu1
// label2 \t valu2
//result in clipboard
// :($1=valu1)
//  $0:="label1"
// :($1=valu2
//  $0:="label2"
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/11/20, 15:15:47
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
End if 
//
C_TEXT:C284($clip; $res_txt)
$clip:=Get text from pasteboard:C524
ARRAY TEXT:C222($lines_atxt; 0)
ut_TextToArray($clip; ->$lines_atxt; "\n")
C_LONGINT:C283($line)

$res_txt:=$res_txt+"C_text($0)\nc_longint($1)\ncase of\n"
For ($line; 1; Size of array:C274($lines_atxt))
	ARRAY TEXT:C222($parts_atxt; 0)
	
	ut_TextToArray($lines_atxt{$line}; ->$parts_atxt; "\t")
	If (Size of array:C274($parts_atxt)>1)
		$res_txt:=$res_txt+":($1="+$parts_atxt{2}+")\n"
		$res_txt:=$res_txt+"$0:=\""+f_TrimStr($parts_atxt{1}; True:C214; True:C214)+"\"\n"
		
	End if 
	
End for 
$res_txt:=$res_txt+"\nEnd case\n"
SET TEXT TO PASTEBOARD:C523($res_txt)
ALERT:C41("Text sent to pasteboard")
//End Dev_buildCaseStatements