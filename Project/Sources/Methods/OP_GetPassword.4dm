//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/26/07, 12:27:50
	// ----------------------------------------------------
	// Method: OP_GetPassword
	// Description
	// get the password; save it in var OP_Password_txt
	// 
	// Parameters
	// $0 : $Error (0=OK ; 1 no good)
	// $1 : $Message_txt 
	// ----------------------------------------------------
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(6/26/09 16:02:51)
	Mods_2009_06  // Changed vsDialogtxt to TEXT
	
End if 
C_LONGINT:C283($0; $ErrorNo_L)
C_TEXT:C284($1; vsDialogTxt)
C_TEXT:C284(OP_Password_txt)
C_TEXT:C284(vsPassword)  // Command Replaced was o_C_STRING length was 80
If (Count parameters:C259=1)
	vsDialogTxt:=$1
Else 
	vsDialogTxt:=Current user:C182+", you are about to transfer data to the remote database."+<>sCR+<>sCR
	vsDialogTxt:=vsDialogTxt+"Please enter your password:"
End if 

C_LONGINT:C283($w_L; $h_L)
FORM GET PROPERTIES:C674([Dialogs:21]; "Get Password"; $w_L; $h_L)
CENTER_WINDOW($w_L; $h_L; Movable dialog box:K34:7)
vsPassword:=""
DIALOG:C40([Dialogs:21]; "Get Password")
CLOSE WINDOW:C154
If (OK=1)
	$ErrorNo_L:=0
Else 
	$ErrorNo_L:=-1
End if 
$0:=$ErrorNo_L
OP_Password_txt:=vsPassword