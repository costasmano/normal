// ----------------------------------------------------
// Object Method: btnPrint
// User name (OS): cjmiller
// Date and time: 03/29/05, 15:59:22
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM02  //03/29/05, 15:59:36 
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 10:32:29)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/15/10 10:37:45)
	Mods_2010_10
	//  `Print the new form "RatingPrintForm_2" for Ratings and Overloads and set to Landscape
End if 
C_TEXT:C284($FormName_txt)

If (Not:C34(((Current user:C182="Designer") | User in group:C338(Current user:C182; "Ratings and Overloads"))))
	G_PrintOptions
	$FormName_txt:="Rating Print Form"
Else 
	G_PrintOptions(2)  //Landscape
	$FormName_txt:="RatingPrintForm_2"
End if 
If (<>ShowPrint)
	PRINT SETTINGS:C106
End if 
If (Ok=1)  //check to see if canceled from Print Settings
	Print form:C5([Conslt Rating:63]; $FormName_txt)
	//end of change
	PAGE BREAK:C6
End if 
//End Object Method: btnPrint