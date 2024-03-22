//%attributes = {"invisible":true}
//Method: NTI_RUNHelpWindow
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 11:45:52
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_LONGINT:C283(NTI_RUNHelpWindow; $1)
	
End if 
//
C_LONGINT:C283($1)

C_LONGINT:C283($elemKey_L)

$elemKey_L:=$1
C_LONGINT:C283(PON_HELPWINDOWID_L; PON_NEWELEMENTNO_L; $w; $h)
PON_NEWELEMENTNO_L:=$1
PON_HELPWINTITLE_TXT:="Help for element "+String:C10($elemKey_L)
FORM GET PROPERTIES:C674("NTIHELP"; $w; $h)
// PON_HELPWINDOWID_L:=Open window(40;40;40+$w;40+$h)
PON_HELPWINDOWID_L:=Open form window:C675("NTIHELP")  // must use this instead of open window!!
DIALOG:C40("NTIHELP")
CLOSE WINDOW:C154

//End TIN_RUNHelpWindow