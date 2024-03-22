//%attributes = {"invisible":true}
// Method: INSP_PRN_InitVars
// Description
// Initialize the print vars for controlling of printing inspections.
//  ie, which parts to print.
// 
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/08/07, 16:49:13
	// ----------------------------------------------------
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM04
	
	// Modified by: costasmanousakis-(Designer)-(1/10/2007 16:26:49)
	Mods_2007_CM02
	// Modified by: Costas Manousakis-(Designer)-(8/5/16 19:14:27)
	Mods_2016_08
	//  `add vars for print destination to pdf
	// Modified by: Costas Manousakis-(Designer)-(12/31/20 16:52:12)
	Mods_2020_12
	//  `added flag to print landscape sketches and charts rotated.
	//Add code that will create PDFs of all [Inspections]InspApproved=2
	// Modified by: Costas Manousakis-(Designer)-(2/25/21 14:38:23)
	Mods_2021_02
	//  `initialize INSP_CreatePDFsofApproved_B
End if 
C_BOOLEAN:C305(PrintFlag)
C_LONGINT:C283(vPrintPhotos; vPrintSketches; vPrintCharts; vPrintCmts; vPrintPage1; vPrintPage2; vPrintSIA; vPrintSpMemPgs; vPrintInvPhotos)  //Command Replaced was o_C_INTEGER//chng.2007..
//2005-02-10 ASL
//Flag in dialog to request printing Pontis report
C_LONGINT:C283(vPrintPontis; vPrintPontisField)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vPageNo; vTotalPages; vPrintPreview)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305(bPhotoFlag; bSketchFlag; bChartFlag; bCmtsFlag; bSpecMemPgsFlag; bPontisFlag; bInvPhotoFlag)  //chng.2007..

C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var
viInspPreviewErr:=0  //initialize Error

bPhotoFlag:=False:C215
bSketchFlag:=False:C215
bChartFlag:=False:C215
bCmtsFlag:=False:C215
bSpecMemPgsFlag:=False:C215
bPontisFlag:=False:C215
bInvPhotoFlag:=False:C215

C_TEXT:C284(PRINT_DestFolder_txt; PRINT_DestFileName_txt; PRINT_TempDestFolder_txt)
C_BOOLEAN:C305(PRINT_PdfDest_b)
C_LONGINT:C283(PRINT_destCount_L)
C_BOOLEAN:C305(Insp_PrintLandscapeRotated; INSP_CreatePDFsofApproved_B)
//iniialize the job name
If (Not:C34(INSP_CreatePDFsofApproved_B))
	PRINT_DestFileName_txt:=[Inspection Type:31]Description:2+"-"+[Inspections:27]BIN:1+"-"+Substring:C12(String:C10([Inspections:27]Insp Date:78; ISO date:K1:8); 1; 10)
	SET PRINT OPTION:C733(Spooler document name option:K47:10; PRINT_DestFileName_txt)
	PRINT_PdfDest_b:=False:C215
End if 
//flag to print landscape sketches and charts rotated.
C_BOOLEAN:C305(Insp_PrintLandscapeRotated)
Insp_PrintLandscapeRotated:=True:C214