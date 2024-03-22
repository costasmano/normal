//%attributes = {"invisible":true}
//Procedure: PRINT_Closed
//Purpose: print the closed bridge inspection form
If (False:C215)
	
	//Created By: Albert Leung
	//Date: May 23, 2003
	//
	//Most of this code is taken from the Print_Dive_F PM.
	//Determine number of pages, allow printing of segments of report,etc.
	
	Mods_2004_CM01
	Mods_2005_CJM02  //03/29/05, 16:10:41
	Mods_2005_CM15
	
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(1/10/2007 16:27:43)
	Mods_2007_CM02
	// Modified by: costasmanousakis-(Designer)-(1/26/2007 11:06:29)
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:21:55)
	Mods_2007_CM12_5301
	Mods_2009_03  //CJM  r001   `03/06/09, 14:15:19`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(8/27/10 11:11:44)
	Mods_2010_08
	//added   `added call to font setup  G_SetInspFont 
	// Modified by: Costas Manousakis-(Designer)-(9/22/20 10:37:53)
	Mods_2020_09_bug
	//  `Added missing code to combine pdfs at the end - Call Reference #748
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(6/29/21 15:25:24)
	Mods_2021_v17
	//  `modified to work in v17 preview must be set after the print settings
	
End if 

C_TEXT:C284($oldWinTitle; $newWinTitle)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(prevSpoolDocName)
C_LONGINT:C283($FormWindow)

INSP_PRN_InitVars

//This creates a job name for the print jobs to follow
$oldWinTitle:=Get window title:C450
$newWinTitle:="Closed Inspection "+[Bridge MHD NBIS:1]BIN:3+" "
SET WINDOW TITLE:C213($newWinTitle)
//added call to font setup
G_SetInspFont

//initialize some variables
G_InitInspVars

sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
//9/2001 end

//Save the current selection of safety elements and images
COPY NAMED SELECTION:C331([ElementsSafety:29]; "TempElmtsClsdPr")
COPY NAMED SELECTION:C331([Standard Photos:36]; "TempImgsClsdPr")
G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)

//1st pass is done to figure out total number of pages....
PrintFlag:=False:C215
bSpecMemPgsFlag:=False:C215  //need to initialize it here.
bInvPhotoFlag:=False:C215
vPrintPhotos:=0  //these are needed to initialize variables used in Print photos method
vPrintSketches:=0
vPrintCharts:=0

//initialize Page Number
vPageNo:=1

G_CountClsdInspPgs

bCmtsFlag:=(viNumCmtsPgs>0)  //found comments 
bSketchFlag:=(viNumSkPgs>0)
bChartFlag:=(viNumChPgs>0)
bPhotoFlag:=(viNumPhPgs>0)

// get/update total number of pages for report and choose what is to be printed

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "PrintInspRpt"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$FormWindow:=Open form window([Dialogs];"PrintInspRpt")
DIALOG:C40([Dialogs:21]; "PrintInspRpt")
CLOSE WINDOW:C154($Win_l)
//ON ERR CALL("G_PrintError")  `Set error handler for quiting from Preview

If (OK=1)
	
	G_PrintOptions
	//GET PRINT OPTION(Spooler document name option ;prevSpoolDocName)
	//SET PRINT OPTION(Spooler document name option ;"Closed-"+[Inspections]BIN+"-"+Str  `ing([Inspections]Insp Date))  `MODS_XXXX_CM
	//PAGE SETUP([Inspections];"Closed Insp Pg1")
	If (<>ShowPrint)
		PRINT SETTINGS:C106
	End if 
	If (OK=1)
		
		If (vPrintPreview=1)
			SET PRINT PREVIEW:C364(True:C214)
		End if 
		
		BRING TO FRONT:C326(Current process:C322)
		
		Print_initPrintToPDF
		
		If (vPrintPage1=1)
			Print form:C5([Inspections:27]; "Closed Insp Pg1")
			//PAGE BREAK
		End if 
		
		//initialize Page Number
		vPageNo:=viCmtsPgStart-1
		
		//Comments pages
		If ((vPrintCmts=1) & (viInspPreviewErr=0))
			PrintFlag:=True:C214
			viNumCmtsPgs:=INSP_PrintComments_WP  // need to call it to set page numbers straight
		Else 
			vPageNo:=viCmtsPgStart+viNumCmtsPgs-1
		End if 
		
		//print photo pages
		If (((vPrintPhotos=1) | (vPrintSketches=1) | (vPrintCharts=1)) & (viInspPreviewErr=0))
			PrintFlag:=True:C214
			Print_Dive_photos
		Else 
			vPageNo:=1+viNumCmtsPgs+viNumSkPgs+viNumChPgs+viNumPhPgs
		End if 
		
		//Print SI&A normal  
		If ((vPrintSIA=1) & (viInspPreviewErr=0))
			INSP_PrintSIA
		End if 
		
		//send a last page break to spool the job
		If ((vPrintPage1=1) | (vPrintCmts=1) | (vPrintPhotos=1) | (vPrintSIA=1) | (vPrintSketches=1) | (vPrintCharts=1))
			PAGE BREAK:C6
		End if 
		
	End if 
	If (vPrintPreview=1)
		SET PRINT PREVIEW:C364(False:C215)
	End if 
	//SET PRINT OPTION(Spooler document name option ;"")  `MODS_XXXX_CM
	
	If (PRINT_PdfDest_b)
		PRINT_CombinePdfs
	End if 
	
	SET PRINT OPTION:C733(Spooler document name option:K47:10; "")  //MODS_XXXX_CM
	SET PRINT OPTION:C733(Destination option:K47:7; 1)
	
End if 

ON ERR CALL:C155("")  //ReSet error handler 
USE NAMED SELECTION:C332("TempElmtsClsdPr")
CLEAR NAMED SELECTION:C333("TempElmtsClsdPr")
USE NAMED SELECTION:C332("TempImgsClsdPr")
CLEAR NAMED SELECTION:C333("TempImgsClsdPr")
SET WINDOW TITLE:C213($oldWinTitle)