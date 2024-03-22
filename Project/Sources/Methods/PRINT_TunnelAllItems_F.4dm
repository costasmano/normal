//%attributes = {"invisible":true}
// Method: PRINT_TunnelAllItems_F
// Description
//  ` copied from PRINT_ROUTINE_F
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 04/29/13, 10:20:53
	// ----------------------------------------------------
	// First Release
	Mods_2013_04
	// Modified by: Costas Manousakis-(Designer)-(9/9/13 14:40:38)
	Mods_2013_09
	//  `call Print_Tunnel_Cmts for both TAL and TOV inspections
	// Modified by: Costas Manousakis-(Designer)-(5/1/16 12:27:38)
	Mods_2016_NTE
	//  `removed INSP_PRINTPontis  ; added NTI_Print
	//  `Ponits is a count of [NTI_ELEM_BIN_INSP] elements - search for the NTEs
	// Modified by: Costas Manousakis-(Designer)-(6/15/16 12:02:38)
	Mods_2016_NTE
	//  `moved the last page break after the NTI_Print
	// Modified by: Costas Manousakis-(Designer)-(8/29/16 14:04:50)
	Mods_2016_08
	//  `set print opt spooler doc name and combine pdfs at the end
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(6/29/21 15:25:24)
	Mods_2021_v17
	//  `modified to work in v17 preview must be set after the print settings
End if 

C_TEXT:C284($oldWinTitle; $newWinTitle; $prevSpoolDocName)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($FormWindow)
INSP_PRN_InitVars
//2005-01-04 ASL
//Guarantee this.
SET PRINT PREVIEW:C364(False:C215)

//This creates a job name for the print jobs to follow
$oldWinTitle:=Get window title:C450
$newWinTitle:="All Items Inspection "+[Bridge MHD NBIS:1]BIN:3+" "
SET WINDOW TITLE:C213($newWinTitle)

//added call to font setup - Oct-2002
G_SetInspFont

G_InitInspVars

sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))

//Save the current selection of safety elements and images
CUT NAMED SELECTION:C334([ElementsSafety:29]; "Temp_PR_RTN_ELMTS")
CUT NAMED SELECTION:C334([Standard Photos:36]; "Temp_PR_RTN_IMGS")
//1st pass is done to figure out total number of pages....
PrintFlag:=False:C215

vPrintPhotos:=0  //these are needed to initialize variables used in Print photos method
vPrintSketches:=0
vPrintCharts:=0
vPrintSpMemPgs:=0

G_CountRTNInspPgs  // this updates selections

bCmtsFlag:=(viNumCmtsPgs>0)  //found comments 
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

QUERY:C277([NTI_ELEM_BIN_INSP:183]; [NTI_ELEM_BIN_INSP:183]INSPID:1=[Inspections:27]InspID:2)
ORDER BY FORMULA:C300([NTI_ELEM_BIN_INSP:183]; NTI_ElemSort)

bPontisFlag:=(Records in selection:C76([NTI_ELEM_BIN_INSP:183])>0)

// get/update total number of pages for report and choose what is to be printed

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "PrintInspRpt2"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
DIALOG:C40([Dialogs:21]; "PrintInspRpt2")
CLOSE WINDOW:C154($Win_l)
If (OK=1)
	
	//PAGE SETUP([Inspections];"Dive Pr Pg 1")
	G_PrintOptions
	If (<>ShowPrint)
		PRINT SETTINGS:C106
	End if 
	If (OK=1)  //user can cancel from the print settings  
		G_PrintOptions
		If (vPrintPreview=1)
			SET PRINT PREVIEW:C364(True:C214)
		End if 
		BRING TO FRONT:C326(Current process:C322)
		
		// 1st  and second page
		//initialize Page Number
		vPageNo:=2
		
		Print_initPrintToPDF
		
		If (vPrintPage1=1)
			Case of 
				: ([Inspections:27]Insp Type:6="TAL")
					Print form:C5([Inspections:27]; "TunnelRoutinePg1")
				: ([Inspections:27]Insp Type:6="TOV")
					Print form:C5([Inspections:27]; "TunnelOverPg1")
			End case 
			If ((vPrintPage2=1) | (vPrintSpMemPgs=1))  //MODS_XXXX_CM
				//PAGE BREAK(>)`MODS_XXXX_CM
			Else 
				//PAGE BREAK(>)
			End if 
		End if 
		
		If ((vPrintPage2=1) & (viInspPreviewErr=0))
			PAGE BREAK:C6(>)  //MODS_XXXX_CM
			Case of 
				: ([Inspections:27]Insp Type:6="TAL")
					Print form:C5([Inspections:27]; "TunnelRoutinePg2")
				: ([Inspections:27]Insp Type:6="TOV")
					Print form:C5([Inspections:27]; "TunnelOverPg2")
			End case 
			If ((vPrintSpMemPgs=1) & (viInspPreviewErr=0))  //MODS_XXXX_CM
				//PAGE BREAK(>)
			Else 
				//PAGE BREAK(>)
			End if 
			
		End if 
		
		If ((vPrintSpMemPgs=1) & (viInspPreviewErr=0))
			//PAGE BREAK(>)`MODS_XXXX_CM
			Print_SpecMem_pg3
		End if 
		
		vPageNo:=viCmtsPgStart-1
		//Comments pages
		If ((vPrintCmts=1) & (Ok=1) & (viInspPreviewErr=0))
			PrintFlag:=True:C214
			viNumCmtsPgs:=Print_Tunnel_Cmts_WP  // need to call it to set page numbers straight
		Else 
			vPageNo:=viCmtsPgStart+viNumCmtsPgs-1
		End if 
		
		//print photo pages
		If (((vPrintPhotos=1) | (vPrintSketches=1) | (vPrintCharts=1)) & (viInspPreviewErr=0))
			PrintFlag:=True:C214
			Print_Dive_photos
		Else 
			vPageNo:=2+viNumSpMPages+viNumCmtsPgs+viNumSkPgs+viNumChPgs+viNumPhPgs
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
			Print form:C5([Bridge MHD NBIS:1]; "TunnelSIA")
		End if 
		
		NTI_Print
		
		//send a last page break to spool the job
		C_BOOLEAN:C305($vbLastbreak)
		$vbLastbreak:=((vPrintPage1=1) | (vPrintPage2=1) | (vPrintSpMemPgs=1) | (vPrintCmts=1))
		$vbLastbreak:=$vbLastbreak | ((vPrintSketches=1) | (vPrintCharts=1) | (vPrintPhotos=1) | (vPrintSIA=1) | (vPrintPontis=1) | (vPrintPontisField=1))
		If ($vbLastbreak)
			PAGE BREAK:C6
		End if 
		
		If (vPrintPreview=1)
			SET PRINT PREVIEW:C364(False:C215)
		End if 
		
		//*****
		If (PRINT_PdfDest_b)
			PRINT_CombinePdfs
		End if 
		
		SET PRINT OPTION:C733(Spooler document name option:K47:10; "")  //MODS_XXXX_CM
		SET PRINT OPTION:C733(Destination option:K47:7; 1)
		
	End if 
End if 
ON ERR CALL:C155("")  //reset the error handler
USE NAMED SELECTION:C332("Temp_PR_RTN_ELMTS")
USE NAMED SELECTION:C332("Temp_PR_RTN_IMGS")
SET WINDOW TITLE:C213($oldWinTitle)