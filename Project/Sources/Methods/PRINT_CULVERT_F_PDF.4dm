//%attributes = {"invisible":true}
//GP: PRINT_CULVERT_F
If (False:C215)
	
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	
	//DBD 01/10/03 Made changes to routine form print code to adjust to culvert
	Mods_2004_CM01
	Mods_2005_CM06
	Mods_2005_CJM02  //03/29/05, 16:01:15
	
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(1/8/2007 14:13:02)
	Mods_2007_CM02
	// Modified by: costasmanousakis-(Designer)-(1/26/2007 11:06:29)
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(4/13/2007 16:23:23)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:18:18)
	Mods_2007_CM12_5301
	Mods_2009_03  //CJM  r001   `03/06/09, 13:00:21`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(12/10/09 08:28:21)
	Mods_2009_12
	//Use method INSP_PRINTPontis
	Mods_2012_12  //r001 `   `Add print routines for new inspection types
	//RRC
	//Modified by: Charles Miller (12/4/12 10:44:01)
	// Modified by: Costas Manousakis-(Designer)-(8/5/16 )
	Mods_2016_08
	//  `move check for page break after the INSP_PRINTPontis call
	//  `set print opt spooler doc name
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 20:57:16)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284($oldWinTitle; $newWinTitle)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($FormWindow)

INSP_PRN_InitVars  //MODS_XXXX_CM
//2005-01-04 ASL
//Guarantee this.

//This creates a job name for the print jobs to follow
$oldWinTitle:=Get window title:C450
//DBD 01/10/03 Changed to Culvert Inspection
$newWinTitle:="Culvert Inspection "+[Bridge MHD NBIS:1]BIN:3+" "
SET WINDOW TITLE:C213($newWinTitle)

//added call to font setup - Oct-2002
G_SetInspFont

G_InitInspVars

sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))

//Save the current selection of safety elements
CUT NAMED SELECTION:C334([ElementsSafety:29]; "Temp_PR_CUL_ELMTS")
CUT NAMED SELECTION:C334([Standard Photos:36]; "Temp_PR_CUL_IMGS")
//1st pass is done to figure out total number of pages....
PrintFlag:=False:C215

//initialize Page Number
vPageNo:=1

bCmtsFlag:=True:C214  //second page (comments) always there.
bSketchFlag:=(viNumSkPgs>0)
bChartFlag:=(viNumChPgs>0)
bPhotoFlag:=(viNumPhPgs>0)
bSpecMemPgsFlag:=(viNumSpMPages>0)

bInvPhotoFlag:=([Inspections:27]InitialInsp:9)  //chng.2007..
ARRAY DATE:C224(aInvPhotoDate_aD; 0)
If (bInvPhotoFlag)
	READ ONLY:C145([InventoryPhotoInsp:112])
	QUERY:C277([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]BIN:2=[Inspections:27]BIN:1)
	SELECTION TO ARRAY:C260([InventoryPhotoInsp:112]InvPhotoDate_D:3; aInvPhotoDate_aD)
	If (Size of array:C274(aInvPhotoDate_aD)>0)
		SORT ARRAY:C229(aInvPhotoDate_aD; <)
		INSERT IN ARRAY:C227(aInvPhotoDate_aD; 1; 1)
	Else 
		bInvPhotoFlag:=False:C215
	End if 
	
Else 
	
End if 

bPontisFlag:=([Combined Inspections:90]BMSInspID:3>0)
INSP_toPDF_SetUpCheckBoxes
G_CountCulvInspPgs

// get/update total number of pages for report and choose what is to be printed

BRING TO FRONT:C326(Current process:C322)
//initialize Page Number
vPageNo:=1


// 1st  
If (vPrintPage1=1)
	//DBD 01/10/03 Changed Routine to Culvert
	If ([Inspection Type:31]Code:1="RRC")
		Print form:C5([Inspections:27]; "RailRoutine Culvert")
	Else 
		Case of 
			: ([Inspections:27]Insp Date:78<=<>InspFormRevDate_4)
				Print form:C5([Inspections:27]; "Culvert Pr Pg 1")
			Else 
				Print form:C5([Inspections:27]; "CulvertPrPg1_v2")
		End case 
	End if 
	If (vPrintSpMemPgs=1)  //MODS_XXXX_CM
		//PAGE BREAK(>) `MODS_XXXX_CM
	Else 
		//PAGE BREAK(>) `MODS_XXXX_CM
	End if 
End if 

If ((vPrintSpMemPgs=1) & (viInspPreviewErr=0))
	Print_SpecMem_pg3
	//PAGE BREAK(>) `MODS_XXXX_CM
End if 

//Comments pages
vPageNo:=viCmtsPgStart-1
If ((vPrintCmts=1) & (viInspPreviewErr=0))
	viNumCmtsPgs:=Print_CUL_Cmts_WP(New object:C1471("printFlag"; True:C214))
Else 
	vPageNo:=viCmtsPgStart+viNumCmtsPgs-1
End if 

//print photo pages
If ((vPrintPhotos=1) | (vPrintSketches=1) | (vPrintCharts=1) & (viInspPreviewErr=0))
	PrintFlag:=True:C214
	Print_Dive_photos
Else 
	vPageNo:=1+viNumSpMPages+viNumCmtsPgs+viNumSkPgs+viNumChPgs+viNumPhPgs
End if 

//Print inventory photo
If (vPrintInvPhotos=1)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	QUERY:C277([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]BIN:2=[Inspections:27]BIN:1)
	QUERY SELECTION:C341([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]InvPhotoDate_D:3=aInvPhotoDate_aD{aInvPhotoDate_aD})
	If (Records in selection:C76([InventoryPhotoInsp:112])=1)
		QUERY:C277([InventoryPhotos:113]; [InventoryPhotos:113]InvPhotoInsp_ID:2=[InventoryPhotoInsp:112]InvPhotoInspID_L:1)
		ORDER BY:C49([InventoryPhotos:113]; [InventoryPhotos:113]Sequence_I:5; >; [InventoryPhotos:113]PhotoDescr_txt:3; >)
		INV_PrintInvInsp(True:C214)  //Bypass setting print settings in the method
	End if 
	//SET AUTOMATIC RELATIONS(True;True)
	
End if 

//Print SI&A normal  
If ((vPrintSIA=1) & (viInspPreviewErr=0))
	INSP_PrintSIA
End if 

INSP_PRINTPontis

//send a last page break to spool the job
C_BOOLEAN:C305($vbLastbreak)
$vbLastbreak:=((vPrintPage1=1) | (vPrintSpMemPgs=1) | (vPrintCmts=1))
$vbLastbreak:=$vbLastbreak | ((vPrintSketches=1) | (vPrintCharts=1) | (vPrintPhotos=1) | (vPrintSIA=1))
$vbLastbreak:=$vbLastbreak | (vPrintPontis=1) | (vPrintPontisField=1)


ON ERR CALL:C155("")  //ReSet error handler
USE NAMED SELECTION:C332("Temp_PR_CUL_ELMTS")
USE NAMED SELECTION:C332("Temp_PR_CUL_IMGS")
SET WINDOW TITLE:C213($oldWinTitle)