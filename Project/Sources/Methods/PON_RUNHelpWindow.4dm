//%attributes = {"invisible":true}
// Method: PON_RUNHelpWindow
// Description
// run help window for an element.
// Parameters
// $1 : Current element key
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/20/15, 09:33:35
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
C_LONGINT:C283($1)

C_LONGINT:C283($elemKey_L)

$elemKey_L:=$1
C_LONGINT:C283(PON_HELPWINDOWID_L; PON_NEWELEMENTNO_L; $w; $h)
PON_NEWELEMENTNO_L:=$1
PON_HELPWINTITLE_TXT:="Help for element "+String:C10($elemKey_L)
FORM GET PROPERTIES:C674("PONHELP"; $w; $h)
// PON_HELPWINDOWID_L:=Open window(40;40;40+$w;40+$h)
PON_HELPWINDOWID_L:=Open form window:C675("PONHELP")  // must use this instead of open window!!
DIALOG:C40("PONHELP")
CLOSE WINDOW:C154
//End PON_RUNHelpWindow