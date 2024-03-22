//%attributes = {"invisible":true}
// Method: PRINT_FREEZE_F
// Description
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/16/09, 20:33:22
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	// Modified by: costasmanousakis-(Designer)-(4/9/09 19:17:36)
	Mods_2009_04
	//  `set the vPrintPhotos, vPrintSketches,vPrintCharts flags to 1 to print them (if any)
	// Modified by: costasmanousakis-(Designer)-(8/27/10 11:11:44)
	Mods_2010_08
	//added   `added call to font setup  G_SetInspFont 
	// Modified by: Costas Manousakis-(Designer)-(8/5/16 )
	Mods_2016_08
	//  `set print opt spooler doc name
	MODS_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	
End if 

C_TEXT:C284($oldWinTitle; $newWinTitle)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($FormWindow)
C_TEXT:C284(sBDEPT; sInspDATE)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(sTOWN)  // Command Replaced was o_C_STRING length was 80

INSP_PRN_InitVars  //Mods_2007_CM04

//This creates a job name for the print jobs to follow
//added call to font setup
G_SetInspFont

//initialize some variables
G_InitInspVars
INSP_toPDF_SetUpCheckBoxes
sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
//9/2001 end

//Save the current selection of safety elements
COPY NAMED SELECTION:C331([ElementsSafety:29]; "TempElmtsCritPr")
COPY NAMED SELECTION:C331([Standard Photos:36]; "TempImgsCritPr")
G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)

//1st pass is done to figure out total number of pages....
PrintFlag:=False:C215
bSpecMemPgsFlag:=False:C215  //need to initialize it here.

G_CountSpInspPgs
//initialize Page Number
vPageNo:=viNumPg1s
bCmtsFlag:=(viNumCmtsPgs>0)  //found comments 
bSketchFlag:=(viNumSkPgs>0)
bChartFlag:=(viNumChPgs>0)
bPhotoFlag:=(viNumPhPgs>0)


// 1st page
vPageNo:=0  //Initialize Page number      



Print_Freeze_pg1
PrintFlag:=True:C214
Print_Dive_photos



ON ERR CALL:C155("")  //ReSet error handler
USE NAMED SELECTION:C332("TempElmtsCritPr")
CLEAR NAMED SELECTION:C333("TempElmtsCritPr")
USE NAMED SELECTION:C332("TempImgsCritPr")
CLEAR NAMED SELECTION:C333("TempImgsCritPr")
SET WINDOW TITLE:C213($oldWinTitle)