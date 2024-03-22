//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/14/07, 21:53:38
	// ----------------------------------------------------
	// Method: INSP_PreviewBtn_OM
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(1/23/2007 16:08:22)
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:41:49)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(2/24/10 16:30:56)
	Mods_2010_02
	//Modifications for PONTIS in spec member inspections
	// Modified by: Costas Manousakis-(Designer)-(1/3/13 10:46:36)
	Mods_2013_01
	//  `Added case for RRD inspection type
	// Modified by: Costas Manousakis-(Designer)-(11/13/13 08:50:44)
	Mods_2013_11
	//  `Added call to INSP_Check4DWriteChgs
	// Modified by: Costas Manousakis-(Designer)-(1/5/15)
	Mods_2015_01
	// Added TDA
	// Modified by: Costas Manousakis-(Designer)-(6/3/15 13:19:17)
	Mods_2015_06
	//  `added case for NBE elements 
	// Modified by: Costas Manousakis-(Designer)-(1/28/21 18:34:59)
	Mods_2021_WP
	//  `WRITE PRO
	// Modified by: Costas Manousakis-(Designer)-(2021-12-29 12:06:25)
	Mods_2021_12_bug
	//  `call INSP_SaveInspCommts
End if 
//Preview pages depending on which form page is current.
SET PRINT PREVIEW:C364(True:C214)
C_BOOLEAN:C305(PrintFlag)
C_LONGINT:C283(vPageNo; vPrintPhotos; vPrintSketches; vPrintCharts)  //Command Replaced was o_C_INTEGER

INSP_SaveInspCommts

COPY NAMED SELECTION:C331([ElementsSafety:29]; "TempElmtsPreview")
COPY NAMED SELECTION:C331([Standard Photos:36]; "TempImagesPreview")
//Count pages
G_CountSpInspPgs
Case of 
	: (([Inspections:27]Insp Type:6="DAM") | ([Inspections:27]Insp Type:6="RRD") | ([Inspections:27]Insp Type:6="TDA"))
		ARRAY INTEGER:C220($Pg1PrintPage_ai; 5)
		$Pg1PrintPage_ai{1}:=1
		$Pg1PrintPage_ai{2}:=2
		$Pg1PrintPage_ai{3}:=3
		$Pg1PrintPage_ai{4}:=4
		$Pg1PrintPage_ai{5}:=8
		C_LONGINT:C283($CmtsPrintPage_i; $ImagePrintPage_i)  //Command Replaced was o_C_INTEGER
		$CmtsPrintPage_i:=5
		$ImagePrintPage_i:=6
		
	Else 
		ARRAY INTEGER:C220($Pg1PrintPage_ai; 3)
		$Pg1PrintPage_ai{1}:=1
		$Pg1PrintPage_ai{2}:=2
		$Pg1PrintPage_ai{3}:=3
		C_LONGINT:C283($CmtsPrintPage_i; $ImagePrintPage_i)  //Command Replaced was o_C_INTEGER
		$CmtsPrintPage_i:=4
		$ImagePrintPage_i:=5
		
End case 

sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
ON ERR CALL:C155("G_PrintError")
C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var
viInspPreviewErr:=0  //initialize Error
//PAGE SETUP([Inspections];"FC Pr (Pg 1)")
G_PrintOptions
C_LONGINT:C283($viCurPg)  //Command Replaced was o_C_INTEGER
$viCurPg:=FORM Get current page:C276
Case of 
	: (Find in array:C230($Pg1PrintPage_ai; $viCurPg)>0)
		vPageNo:=0
		Print_SpecMem_pg1
		PAGE BREAK:C6
		
	: ($viCurPg=$CmtsPrintPage_i)
		vPageNo:=viCmtsPgStart-1
		PrintFlag:=True:C214
		C_LONGINT:C283($vlNumCmtPgs)
		$vlNumCmtPgs:=INSP_PrintComments_WP
		If ($vlNumCmtPgs=0)
			ALERT:C41("There are no Comments for this Inspection")
		Else 
			PAGE BREAK:C6
		End if 
		
	: (FORM Get current page:C276=$ImagePrintPage_i)
		G_PreviewInspImage
		
	: (vTabRoutingPages{$viCurPg}="Pontis")
		INSP_PreviewBrM
	: (vTabRoutingPages{$viCurPg}="NBE")
		INSP_PreviewBrM
End case 

SET PRINT PREVIEW:C364(False:C215)
ON ERR CALL:C155("")
USE NAMED SELECTION:C332("TempElmtsPreview")
USE NAMED SELECTION:C332("TempImagesPreview")
CLEAR NAMED SELECTION:C333("TempElmtsPreview")
CLEAR NAMED SELECTION:C333("TempImagesPreview")