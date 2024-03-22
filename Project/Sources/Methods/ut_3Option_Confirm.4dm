//%attributes = {"invisible":true}
If (False:C215)
	//ut_3Option_Confirm 
	
	Mods_2004_CM12
	
End if 

C_LONGINT:C283($0; $RetValue)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($1)
C_TEXT:C284($2; $3; $4)  // Command Replaced was o_C_STRING length was 15

C_TEXT:C284(vtChoice_1_STR; vtChoice_2_STR; vtChoice_3_STR)  // Command Replaced was o_C_STRING length was 15
C_LONGINT:C283(vbChoice_1; vbChoice_2; vbChoice_3)  //Command Replaced was o_C_INTEGER
C_TEXT:C284(vTextMsg)

//initialize form variables
vTextMsg:=""
vtChoice_1_STR:=""
vtChoice_2_STR:=""
vtChoice_3_STR:=""

vTextMsg:=$1
If (Count parameters:C259>1)
	vtChoice_1_STR:=$2
End if 
If (Count parameters:C259>2)
	vtChoice_2_STR:=$3
End if 
If (Count parameters:C259>3)
	vtChoice_3_STR:=$4
End if 
C_LONGINT:C283($w; $H)
FORM GET PROPERTIES:C674([Dialogs:21]; "3OptionConfirm"; $W; $H)
//$tempwin:=Open form window([Dialogs];"3OptionConfirm";Movable form dialog box )
CENTER_WINDOW($w; $H; Movable form dialog box:K39:8)
DIALOG:C40([Dialogs:21]; "3OptionConfirm")
CLOSE WINDOW:C154
Case of 
	: (vbChoice_1=1)
		$RetValue:=1
	: (vbChoice_2=1)
		$RetValue:=2
	: (vbChoice_3=1)
		$RetValue:=3
End case 

//Clear Form text variables
vTextMsg:=""
vtChoice_1_STR:=""
vtChoice_2_STR:=""
vtChoice_3_STR:=""

$0:=$RetValue