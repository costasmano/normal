//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// G_PreviewInspImage
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:09:53
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	
	//G_PreviewInspImage 
	//Method used to do a print preview of Images for an Inspection.
	//Called from Preview buttons on Inspection input forms.
	//Created Apr-2003
	Mods_2005_CJM02  //03/29/05, 16:10:08
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 10:28:36)
	Mods_2007_CM12_5301
End if 

If (Records in selection:C76([Standard Photos:36])>0)
	
	C_LONGINT:C283(vPageNo)  //Command Replaced was o_C_INTEGER
	C_BOOLEAN:C305(PrintFlag)
	vPageNo:=viSkPgStart-1
	PrintFlag:=True:C214
	vPrintPhotos:=1
	vPrintSketches:=1
	vPrintCharts:=1
	G_PrintOptions
	//PAGE SETUP([Inspections];"Dive Pr Pg 1")
	Print_Dive_photos
	PAGE BREAK:C6
	
End if 