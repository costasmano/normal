//[Inspections];"Dive Template".vbPG1Preview
//Preview pages depending on which form page is current.
If (False:C215)
	// ----------------------------------------------------
	// Object Method: vbPG1Preview
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 15:56:16
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM02  //03/29/05, 15:56:19 
	// Modified by: costasmanousakis-(Designer)-(1/23/2007 16:08:22)
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 10:27:33)
	Mods_2007_CM12_5301
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 14:00:59
	// Modified by: Costas Manousakis-(Designer)-(5/8/12 16:13:24)
	Mods_2012_05
	//  `Added DVF form , and calls to resize window at the end to clear phantom blank spots
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23T00:00:00 13:44:34)
	Mods_2021_12_bug
	//  `call INSP_SaveInspCommts
End if 
INSP_SaveInspCommts

SET PRINT PREVIEW:C364(True:C214)
sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
ON ERR CALL:C155("G_PrintError")
C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var
viInspPreviewErr:=0  //initialize Error

COPY NAMED SELECTION:C331([ElementsSafety:29]; "TempElmtsPreview")
COPY NAMED SELECTION:C331([Standard Photos:36]; "TempImagesPreview")

G_CountDiveInspPgs

C_LONGINT:C283($viCurPg)  //Command Replaced was o_C_INTEGER
$viCurPg:=FORM Get current page:C276
Case of 
	: (($viCurPg=1) | ($viCurPg=2))
		G_PrintOptions
		//PAGE SETUP([Inspections];"Dive Pr Pg 1")
		Case of 
			: ([Inspections:27]Insp Type:6="DVL")
				Print form:C5([Inspections:27]; "Dive Pr  LowCl Pg1")
			: ([Inspections:27]Insp Type:6="DVE")
				Print form:C5([Inspections:27]; "Dive Pr Pg 1")
			: ([Inspections:27]Insp Type:6="DVS")
				Print form:C5([Inspections:27]; "Dive Special Pr Pg 1")
			: ([Inspections:27]Insp Type:6="DVF")
				Print form:C5([Inspections:27]; "StormDamageInspectionPr")
			Else 
				Print form:C5([Inspections:27]; "Dive Pr Pg 1")
		End case 
		PAGE BREAK:C6
		
	: ($viCurPg=3)
		C_LONGINT:C283(vPageNo)  //Command Replaced was o_C_INTEGER
		C_BOOLEAN:C305(PrintFlag)
		PrintFlag:=True:C214
		G_PrintOptions
		//PAGE SETUP([Inspections];"Dive Pr Pg 1")
		vPageNo:=viCmtsPgStart-1
		vPageNo:=INSP_PrintComments_WP
		If (vPageNo=0)
			ALERT:C41("There are no Comments for this Inspection")
		Else 
			PAGE BREAK:C6
		End if 
		
	: ($viCurPg=4)
		G_PreviewInspImage
End case 

//reset the list of Elements to where it was
SET PRINT PREVIEW:C364(False:C215)
ON ERR CALL:C155("")
USE NAMED SELECTION:C332("TempElmtsPreview")
USE NAMED SELECTION:C332("TempImagesPreview")
CLEAR NAMED SELECTION:C333("TempElmtsPreview")
CLEAR NAMED SELECTION:C333("TempImagesPreview")

C_LONGINT:C283($WL; $WT; $WR; $WB)
GET WINDOW RECT:C443($WL; $WT; $WR; $WB)
SET WINDOW RECT:C444($WL; $WT; $WR; $WB+1)
SET WINDOW RECT:C444($WL; $WT; $WR; $WB)