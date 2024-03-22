//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/29/07, 08:40:25
	// ----------------------------------------------------
	// Method: LTR_GetLetterDate
	// Description
	// Set the date of a letter
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
End if 
C_LONGINT:C283($dlgWidh_L; $dlgHt_L)
FORM GET PROPERTIES:C674([Dialogs:21]; "LetterDateDialog"; $dlgWidh_L; $dlgHt_L)
CENTER_WINDOW($dlgWidh_L; $dlgHt_L)
DIALOG:C40([Dialogs:21]; "LetterDateDialog")
CLOSE WINDOW:C154