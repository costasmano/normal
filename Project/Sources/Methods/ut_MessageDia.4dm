//%attributes = {"invisible":true}
//ut_MessageDia
//$1 : Text : Message
//$2 : A80 : window title
//$3 : Int : Delay in minutes between BEEPs
//$4 : LInt : Number of BEEPs
If (False:C215)
	
	Mods_2004_CM09
	
End if 

C_TEXT:C284($1; vtMessage)
C_TEXT:C284($2; $vsMsgTitle)  // old C_STRING length 80
C_LONGINT:C283($3; viMinDelay)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_LONGINT:C283($4; vlMessageTimerLimit)
vtMessage:=$1
$vsMsgTitle:=$2
If (Count parameters:C259>2)
	viMinDelay:=$3
End if 
If (Count parameters:C259>3)
	vlMessageTimerLimit:=$4
End if 
C_LONGINT:C283($fwidth; $fheight)
FORM GET PROPERTIES:C674([Dialogs:21]; "MessageDia"; $fwidth; $fheight)
NewWindow($fwidth; $fheight; 7; Plain window:K34:13; $vsMsgTitle)
DIALOG:C40([Dialogs:21]; "MessageDia")
CLOSE WINDOW:C154
vtMessage:=""