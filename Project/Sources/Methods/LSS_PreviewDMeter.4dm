//%attributes = {"invisible":true}
//Method: LSS_PreviewDMeter
//Description
// Preview the D-Meter Page
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/20/16, 17:04:31
	// ----------------------------------------------------
	//Created : 
	Mods_2016_04_bug
End if 
//

G_PrintOptions

LSS_SetDefDMeterNotes

ALERT:C41("Page numbering is not correct in this Preview!")
CREATE EMPTY SET:C140([LSS_Photos:166]; "DMeterPhotoSet")
ADD TO SET:C119([LSS_Photos:166]; "DMeterPhotoSet")
SET PRINT PREVIEW:C364(True:C214)

Print form:C5([LSS_Inspection:164]; "Print_DMeter")

PAGE BREAK:C6

SET PRINT PREVIEW:C364(False:C215)
CLEAR SET:C117("DMeterPhotoSet")

//End LSS_PreviewDMeter