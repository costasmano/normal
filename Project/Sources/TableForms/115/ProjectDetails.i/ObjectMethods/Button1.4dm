If (False:C215)
	// ----------------------------------------------------
	// Object Method: Button1
	// User name (OS): cjmiller
	// Date and time: 10/13/06, 11:47:27
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CJMv2
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:16:45)
	Mods_2007_CM12_5301
End if 
C_LONGINT:C283($LastScale_l; $LastOrient_l)
GET PRINT OPTION:C734(Orientation option:K47:2; $LastOrient_l)
GET PRINT OPTION:C734(Scale option:K47:3; $LastScale_l)

FORM SET OUTPUT:C54([PRJ_ProjectDetails:115]; "PRJ_Details.rpt")
G_PrintOptions(2; ""; 94)
PRINT SETTINGS:C106
If (OK=1)
	PRINT RECORD:C71([PRJ_ProjectDetails:115]; >)
End if 
FORM SET OUTPUT:C54([PRJ_ProjectDetails:115]; "ProjectDetails.o")
G_PrintOptions($LastOrient_l; ""; $LastScale_l)

//End Object Method: Button1