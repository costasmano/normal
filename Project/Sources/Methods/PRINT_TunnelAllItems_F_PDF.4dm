//%attributes = {"invisible":true}
// Method: PRINT_TunnelAllItems_F_PDF
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
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284($oldWinTitle; $newWinTitle; $prevSpoolDocName)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($FormWindow)
INSP_PRN_InitVars
//2005-01-04 ASL
//Guarantee this.
SET PRINT PREVIEW:C364(False:C215)

//This creates a job name for the print jobs to follow

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
INSP_toPDF_SetUpCheckBoxes
G_CountRTNInspPgs  // this updates selections

bCmtsFlag:=(viNumCmtsPgs>0)  //found comments 
bSketchFlag:=(viNumSkPgs>0)
bChartFlag:=(viNumChPgs>0)
bPhotoFlag:=(viNumPhPgs>0)
bSpecMemPgsFlag:=(viNumSpMPages>0)

QUERY:C277([NTI_ELEM_BIN_INSP:183]; [NTI_ELEM_BIN_INSP:183]INSPID:1=[Inspections:27]InspID:2)
ORDER BY FORMULA:C300([NTI_ELEM_BIN_INSP:183]; NTI_ElemSort)

bPontisFlag:=(Records in selection:C76([NTI_ELEM_BIN_INSP:183])>0)

// get/update total number of pages for report and choose what is to be printed


BRING TO FRONT:C326(Current process:C322)

// 1st  and second page
//initialize Page Number
vPageNo:=2



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



ON ERR CALL:C155("")  //reset the error handler
USE NAMED SELECTION:C332("Temp_PR_RTN_ELMTS")
USE NAMED SELECTION:C332("Temp_PR_RTN_IMGS")
SET WINDOW TITLE:C213($oldWinTitle)