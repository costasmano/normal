If (False:C215)
	// ----------------------------------------------------
	// Object Method: [Inspections];"Closed Bridge".Page Preview Btn
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 15:56:47
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2005_CM05
	Mods_2005_CJM02  //03/29/05, 15:56:56
	// Modified by: costasmanousakis-(Designer)-(1/23/2007 16:08:22)
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 10:29:28)
	Mods_2007_CM12_5301
	
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 14:00:59
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23T00:00:00 13:44:34)
	Mods_2021_12_bug
	//  `call INSP_SaveInspCommts
End if 
INSP_SaveInspCommts

//[Inspections]Closed Bridge.vbPGPreview
//Preview pages depending on which form page is current.
SET PRINT PREVIEW:C364(True:C214)
C_BOOLEAN:C305(PrintFlag)
C_LONGINT:C283(vPageNo; vPrintPhotos; vPrintSketches; vPrintCharts)  //Command Replaced was o_C_INTEGER

COPY NAMED SELECTION:C331([ElementsSafety:29]; "TempElmtsPreview")
COPY NAMED SELECTION:C331([Standard Photos:36]; "TempImagesPreview")

G_CountClsdInspPgs  //count pages

sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
ON ERR CALL:C155("G_PrintError")
C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var
viInspPreviewErr:=0  //initialize Error
G_PrintOptions

//PAGE SETUP([Inspections];"Closed Insp Pg1")
C_LONGINT:C283($viCurPg)  //Command Replaced was o_C_INTEGER
$viCurPg:=FORM Get current page:C276
Case of 
	: (($viCurPg=1) | ($viCurPg=2) | ($viCurPg=3) | ($viCurPg=6))
		Print form:C5([Inspections:27]; "Closed Insp Pg1")
		PAGE BREAK:C6
		
	: ($viCurPg=4)
		vPageNo:=viCmtsPgStart-1
		PrintFlag:=True:C214
		C_LONGINT:C283($vlNumCmtPgs)
		$vlNumCmtPgs:=INSP_PrintComments_WP
		If ($vlNumCmtPgs=0)
			ALERT:C41("There are no Comments for this Inspection")
		Else 
			PAGE BREAK:C6
		End if 
		
	: ($viCurPg=5)
		G_PreviewInspImage
		
End case 

SET PRINT PREVIEW:C364(False:C215)
ON ERR CALL:C155("")
USE NAMED SELECTION:C332("TempElmtsPreview")
USE NAMED SELECTION:C332("TempImagesPreview")
CLEAR NAMED SELECTION:C333("TempElmtsPreview")
CLEAR NAMED SELECTION:C333("TempImagesPreview")