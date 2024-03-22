//%attributes = {"shared":true}
If (False:C215)
	//QR_Item26OnOff 
	// Modified by: Costas Manousakis-(Designer)-(3/25/14 15:35:45)
	Mods_2014_03
	//  `added optional parameter for Item 26
End if 

C_TEXT:C284($item26)  // Command Replaced was o_C_STRING length was 2

C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 3
$item26:=[Bridge MHD NBIS:1]Item26:120

If (Count parameters:C259>0)
	C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 2
	$item26:=$1
End if 

Case of 
	: (Position:C15($item26; "-01-02-06-07-11-12-14-16-17-")>0)
		$0:="On"
	: (Position:C15($item26; "-08-09-19-")>0)
		$0:="Off"
	Else 
		$0:="???"
End case 