//%attributes = {"invisible":true}
//Method: ut_TestDialog
//Description
//  `Run dialog "WriteArea" to test 4D Write text properties
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/05/13, 15:49:20
	// ----------------------------------------------------
	//Created : 
	Mods_2013_11
	// Modified by: Costas Manousakis-(Designer)-(11/14/13 12:30:18)
	Mods_2013_11
	//  `was renamed from ut_Test4DWriteArea 
	//  `made to run multiple forms
End if 
//
ARRAY TEXT:C222($testForms; 0)
APPEND TO ARRAY:C911($testForms; "WriteTest")
APPEND TO ARRAY:C911($testForms; "WebAreaTest")
APPEND TO ARRAY:C911($testForms; "MAP_MultipleBridges")
APPEND TO ARRAY:C911($testForms; "DateTimeClock")
C_LONGINT:C283($pickform_L)
$pickform_L:=G_PickFromList(->$testForms; "Pick a form to test")

If ($pickform_L>0)
	C_LONGINT:C283($winID)
	$winID:=Open form window:C675($testForms{$pickform_L})
	DIALOG:C40($testForms{$pickform_L})
	CLOSE WINDOW:C154
	
End if 

//End ut_TestDialog