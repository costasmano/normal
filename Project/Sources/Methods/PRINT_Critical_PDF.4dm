//%attributes = {"invisible":true}
If (False:C215)
	
	//Procedure: PRINT_Critical_pdf
	//Created By: Albert Leung
	//Date: April 1, 2003
	//Purpose: print the fracture critical inspection form
	
	//Most of this code is taken from the Print_Dive_F PM.
	//Determine number of pages, allow printing of segments of report,etc.
	Mods_2004_CM01
	Mods_2005_CM01
	Mods_2005_CJM02  //03/29/05, 16:00:55
	Mods_2005_VN01
	
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(1/26/2007 11:06:29)
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:17:36)
	Mods_2007_CM12_5301
	Mods_2009_03  //CJM  r001   `03/06/09, 12:58:22`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(2/25/10 16:33:44)
	Mods_2010_02
	//  `Added INSP_PRINTPontis call
	// Modified by: costasmanousakis-(Designer)-(8/27/10 11:11:44)
	Mods_2010_08
	//added   `added call to font setup  G_SetInspFont 
	// Modified by: Costas Manousakis-(Designer)-(1/3/13 10:50:39)
	Mods_2013_01
	//  `Added case for RRS, RRF, RRO, RRD inspection types
	Mods_2013_05  //r003 ` Add [Inspections]Insp Type="TSP
	//Modified by: Charles Miller (5/9/13 10:47:14)
	// Modified by: Costas Manousakis-(Designer)-(1/6/15 17:00:17)
	Mods_2015_01
	//  `  `  `added TDA : tunnel damage
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 15:25:49)
	Mods_2015_02
	//  `  `  `added TOT : tunnel Other
	// Modified by: Costas Manousakis-(Designer)-(6/3/15 12:45:41)
	// Modified by: Costas Manousakis-(Designer)-(8/5/16 10:45:54)
	Mods_2016_08
	//  `move check for page break after the INSP_PRINTPontis call
	//  `if Tunnel inspection print Tunnel SIA
	//  `set print opt spooler doc name
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284($oldWinTitle; $newWinTitle)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($FormWindow)
C_TEXT:C284(sBDEPT; sInspDATE)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(sTOWN)  // Command Replaced was o_C_STRING length was 80

INSP_PRN_InitVars  //Mods_2007_CM04

//This creates a job name for the print jobs to follow
$oldWinTitle:=Get window title:C450
Case of 
	: ([Inspections:27]Insp Type:6="CMI")
		$newWinTitle:="Spec Memb "+[Bridge MHD NBIS:1]BIN:3+" "
	: ([Inspections:27]Insp Type:6="FCR")
		$newWinTitle:="Fract Crit "+[Bridge MHD NBIS:1]BIN:3+" "
	: ([Inspections:27]Insp Type:6="OTH")
		$newWinTitle:="Other "+[Bridge MHD NBIS:1]BIN:3+" "
	: ([Inspections:27]Insp Type:6="DAM")
		$newWinTitle:="Damage "+[Bridge MHD NBIS:1]BIN:3+" "
	: ([Inspections:27]Insp Type:6="RRS")
		$newWinTitle:="Spec Memb "+[Bridge MHD NBIS:1]BIN:3+" "
	: ([Inspections:27]Insp Type:6="RRF")
		$newWinTitle:="Fract Crit "+[Bridge MHD NBIS:1]BIN:3+" "
	: ([Inspections:27]Insp Type:6="RRO")
		$newWinTitle:="Other "+[Bridge MHD NBIS:1]BIN:3+" "
	: ([Inspections:27]Insp Type:6="RRD")
		$newWinTitle:="Damage "+[Bridge MHD NBIS:1]BIN:3+" "
	: ([Inspections:27]Insp Type:6="TSP")
		$newWinTitle:="Spec Memb "+[Bridge MHD NBIS:1]BIN:3+" "
	: ([Inspections:27]Insp Type:6="TOT")
		$newWinTitle:="Other "+[Bridge MHD NBIS:1]BIN:3+" "
	: ([Inspections:27]Insp Type:6="TDA")
		$newWinTitle:="Damage "+[Bridge MHD NBIS:1]BIN:3+" "
		
End case 
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

vPrintPhotos:=0  //these are needed to initialize variables used in Print photos method
vPrintSketches:=0
vPrintCharts:=0
vPrintPage1:=1
INSP_toPDF_SetUpCheckBoxes

G_CountSpInspPgs
//initialize Page Number
vPageNo:=viNumPg1s
bCmtsFlag:=(viNumCmtsPgs>0)  //found comments 
bSketchFlag:=(viNumSkPgs>0)
bChartFlag:=(viNumChPgs>0)
bPhotoFlag:=(viNumPhPgs>0)
// get/update total number of pages for report and choose what is to be printed

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)


//need to load INSP_LoadElmLabelsforReport(by base type)
// 1st page
vPageNo:=0  //Initialize Page number      



If (vPrintPage1=1)
	Print_SpecMem_pg1
	//PAGE BREAK         `Mods_2007_CM04
Else 
	vPageNo:=viNumPg1s
End if 

//Comments pages
If ((vPrintCmts=1) & (viInspPreviewErr=0))
	PrintFlag:=True:C214
	viNumCmtsPgs:=INSP_PrintComments_WP
Else 
	vPageNo:=viNumPg1s+viNumCmtsPgs
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
	
	If ([Inspections:27]Insp Type:6="T@")  //tunnel inspection
		Print form:C5([Bridge MHD NBIS:1]; "TunnelSIA")
	Else 
		INSP_PrintSIA
	End if 
	
End if 

//SET PRINT OPTION(Spooler document name option ;"")  `Mods_2007_CM04
INSP_PRINTPontis  //Mods_2010_02
//  //send a last page break to spool the job
//If ((vPrintPage1=1) | (vPrintCmts=1) | (vPrintPhotos=1) | (vPrintSIA=1) | (vPrintSketches=1) | (vPrintCharts=1) | (vPrintPontis=1) | (vPrintPontisField=1))
//PAGE BREAK
//End if 




ON ERR CALL:C155("")  //ReSet error handler
USE NAMED SELECTION:C332("TempElmtsCritPr")
CLEAR NAMED SELECTION:C333("TempElmtsCritPr")
USE NAMED SELECTION:C332("TempImgsCritPr")
CLEAR NAMED SELECTION:C333("TempImgsCritPr")
SET WINDOW TITLE:C213($oldWinTitle)