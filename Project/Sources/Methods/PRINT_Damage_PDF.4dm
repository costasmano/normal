//%attributes = {"invisible":true}
//Procedure: PRINT_Damage_PDF
//Created By: Albert Leung
//Date: May 14, 2003
//Purpose: print the damage inspection form
//
If (False:C215)
	//Most of this code is taken from the Print_Dive_F PM.
	//Determine number of pages, allow printing of segments of report,etc.
	Mods_2004_CM01
	Mods_2005_CJM02  //03/29/05, 16:01:42
	Mods_2005_CM15
	// Modified by: costasmanousakis-(Designer)-(1/26/2007 11:06:29)
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:18:38)
	Mods_2007_CM12_5301
	Mods_2009_03  //CJM  r001   `03/06/09, 13:01:07`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(8/27/10 11:11:44)
	Mods_2010_08
	//added   `added call to font setup  G_SetInspFont 
	//Added call to INSP_PRN_InitVars
	// Modified by: Costas Manousakis-(Designer)-(3/11/13 11:50:06)
	Mods_2013_03
	//  `Use method  G_CountSpInspPgs
	// Modified by: Costas Manousakis-(Designer)-(8/5/16 )
	Mods_2016_08
	//  `set print opt spooler doc name
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284($oldWinTitle; $newWinTitle)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($FormWindow)

INSP_PRN_InitVars
//This creates a job name for the print jobs to follow
$oldWinTitle:=Get window title:C450
$newWinTitle:="Damage Inspection "+[Bridge MHD NBIS:1]BIN:3+" "
SET WINDOW TITLE:C213($newWinTitle)

//added call to font setup
G_SetInspFont

//initialize some variables
G_InitInspVars

sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
//9/2001 end

//Save the current selection of safety elements and images
COPY NAMED SELECTION:C331([ElementsSafety:29]; "ElmtsDamagePrt")
COPY NAMED SELECTION:C331([Standard Photos:36]; "ImagesDamagePrt")

G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)

//1st pass is done to figure out total number of pages....
PrintFlag:=False:C215
bSpecMemPgsFlag:=False:C215  //need to initialize it here.
//initialize Page Number
vPageNo:=1
INSP_toPDF_SetUpCheckBoxes
G_CountSpInspPgs

vPageNo:=viNumPg1s
bCmtsFlag:=(viNumCmtsPgs>0)  //found comments 
bSketchFlag:=(viNumSkPgs>0)
bChartFlag:=(viNumChPgs>0)
bPhotoFlag:=(viNumPhPgs>0)

// get/update total number of pages for report and choose what is to be printed

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)



// 1st page
vPageNo:=0  //Initialize Page number      



If (vPrintPage1=1)
	Print_SpecMem_pg1
	PAGE BREAK:C6
Else 
	vPageNo:=viNumPg1s
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
	vPageNo:=viNumPg1s+viNumCmtsPgs+viNumSkPgs+viNumChPgs+viNumPhPgs
End if 

//Print SI&A normal  
If ((vPrintSIA=1) & (viInspPreviewErr=0))
	INSP_PrintSIA
End if 




ON ERR CALL:C155("")  //ReSet error handler
USE NAMED SELECTION:C332("ElmtsDamagePrt")
USE NAMED SELECTION:C332("ImagesDamagePrt")
CLEAR NAMED SELECTION:C333("ElmtsDamagePrt")
CLEAR NAMED SELECTION:C333("ImagesDamagePrt")
SET WINDOW TITLE:C213($oldWinTitle)