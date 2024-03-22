//%attributes = {"invisible":true}
//G_MyConfirm
//Confirm method to allow for messages longer than 255 chars.
//Parameters:
// $1 : vtMessage : text
// $2 : vButtonOK_txt : text (optional) 
// $3 : vButtonCancel_txt : text (optional)
// $4 : viMinDelay : integer (optional) : delay in minutes afer which a bell will beep.
// $5 : vlMessageTimerLimit : long (optional) : how many times the delay will be repeated 
//  `if zero, it will be repeated for 20 times.

If (False:C215)
	//2004-05-23 : Created as general method to provide a confirmation dialogue with a message longer than 255 chars.
	// Modified by: costasmanousakis-(Designer)-(8/31/2006 15:28:03)
	Mods_2006_CM06
	
	// Modified by: costasmanousakis-(Designer)-(4/23/08 13:41:51)
	Mods_2008_CM_5403  //Added parameters to specify Timer delay
	Mods_2011_06  // CJ Miller`06/14/11, 10:34:24      ` Type all local variables for v11
End if 

C_TEXT:C284($1; $2; $3)
C_TEXT:C284(vtMessage; vButtonOK_txt; vButtonCancel_txt)
C_LONGINT:C283(viMinDelay)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vlMessageTimerLimit)
vtMessage:=$1
vButtonOK_txt:=""
vButtonCancel_txt:=""
If (Count parameters:C259>1)
	vButtonOK_txt:=$2
End if 
If (Count parameters:C259>2)
	vButtonCancel_txt:=$3
End if 
viMinDelay:=0
vlMessageTimerLimit:=0
If (Count parameters:C259>3)
	C_LONGINT:C283($4)  //Command Replaced was o_C_INTEGER
	viMinDelay:=$4
End if 
If (Count parameters:C259>4)
	C_LONGINT:C283($5)
	vlMessageTimerLimit:=$5
End if 
C_LONGINT:C283($fwidth; $fheight)
FORM GET PROPERTIES:C674([Dialogs:21]; "MyConfirm"; $fwidth; $fheight)
NewWindow($fwidth; $fheight; 6; Plain window:K34:13; "Confirm")
DIALOG:C40([Dialogs:21]; "MyConfirm")
CLOSE WINDOW:C154
vtMessage:=""
vButtonOK_txt:=""
vButtonCancel_txt:=""
viMinDelay:=0
vlMessageTimerLimit:=0