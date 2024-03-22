//%attributes = {"invisible":true}
//ut_BigAlert 
//display a text alert expandable window and ability to copy the alert to the clipboard
//Parameters
// $1 : $Message
// $2 : $WinTitle_txt (optional)
If (False:C215)
	//ut_BigAlert 
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(3/15/10 13:23:07)
	Mods_2010_03
	//  `made window type Plain Window
	// Modified by: Costas Manousakis-(Designer)-(12/9/16 13:40:27)
	Mods_2016_12
	//  `Added optional parameter for Window title
End if 

C_TEXT:C284($1; vtMessage; $winTitle_txt)
vtMessage:=$1
$winTitle_txt:=""
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$winTitle_txt:=$2
End if 
C_LONGINT:C283($fwidth; $fheight)
FORM GET PROPERTIES:C674([Dialogs:21]; "BigAlert"; $fwidth; $fheight)
NewWindow($fwidth; $fheight; 0; Plain window:K34:13; $winTitle_txt)
DIALOG:C40([Dialogs:21]; "BigAlert")
CLOSE WINDOW:C154
vtMessage:=""