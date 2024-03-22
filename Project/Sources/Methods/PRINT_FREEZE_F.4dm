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
	// Modified by: Costas Manousakis-(Designer)-(6/29/21 15:25:24)
	Mods_2021_v17
	//  `modified to work in v17 preview must be set after the print settings
End if 

C_TEXT:C284($oldWinTitle; $newWinTitle)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($FormWindow)
C_TEXT:C284(sBDEPT; sInspDATE)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(sTOWN)  // Command Replaced was o_C_STRING length was 80

INSP_PRN_InitVars  //Mods_2007_CM04

//This creates a job name for the print jobs to follow
$oldWinTitle:=Get window title:C450
$newWinTitle:="FreezeThaw "+[Bridge MHD NBIS:1]BIN:3+" "
SET WINDOW TITLE:C213($newWinTitle)

//added call to font setup
G_SetInspFont

//initialize some variables
G_InitInspVars

sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
//9/2001 end

//Save the current selection of safety elements
COPY NAMED SELECTION:C331([ElementsSafety:29]; "TempElmtsCritPr")
COPY NAMED SELECTION:C331([Standard Photos:36]; "TempImgsCritPr")
G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)

//1st pass is done to figure out total number of pages....
PrintFlag:=False:C215
bSpecMemPgsFlag:=False:C215  //need to initialize it here.

vPrintPhotos:=1  //these are needed to initialize variables used in Print photos method
vPrintSketches:=1
vPrintCharts:=1

G_CountSpInspPgs
//initialize Page Number
vPageNo:=viNumPg1s
bCmtsFlag:=(viNumCmtsPgs>0)  //found comments 
bSketchFlag:=(viNumSkPgs>0)
bChartFlag:=(viNumChPgs>0)
bPhotoFlag:=(viNumPhPgs>0)
C_LONGINT:C283($UserChoise_L)
$UserChoise_L:=ut_3Option_Confirm("Print report; Preview or Cancel?"; "Print"; "Preview"; "Cancel")
vPrintPhotos:=1

If ($UserChoise_L#3)
	
	G_PrintOptions
	If (<>ShowPrint)
		PRINT SETTINGS:C106
		If ($UserChoise_L=2)
			SET PRINT PREVIEW:C364(True:C214)
		End if 
	End if 
	If (OK=1)
		BRING TO FRONT:C326(Current process:C322)
		// 1st page
		vPageNo:=0  //Initialize Page number      
		
		Print_initPrintToPDF
		
		Print_Freeze_pg1
		PrintFlag:=True:C214
		Print_Dive_photos
		PAGE BREAK:C6
		
		If (PRINT_PdfDest_b)
			PRINT_CombinePdfs
		End if 
		
		SET PRINT OPTION:C733(Spooler document name option:K47:10; "")  //MODS_XXXX_CM
		SET PRINT OPTION:C733(Destination option:K47:7; 1)
		
	End if 
	If ($UserChoise_L=2)
		SET PRINT PREVIEW:C364(False:C215)
	End if 
	
End if 

ON ERR CALL:C155("")  //ReSet error handler
USE NAMED SELECTION:C332("TempElmtsCritPr")
CLEAR NAMED SELECTION:C333("TempElmtsCritPr")
USE NAMED SELECTION:C332("TempImgsCritPr")
CLEAR NAMED SELECTION:C333("TempImgsCritPr")
SET WINDOW TITLE:C213($oldWinTitle)