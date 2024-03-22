//%attributes = {"invisible":true}
//Method: NTI_PrintInspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/27/16, 09:22:24
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(8/29/16 17:10:24)
	Mods_2016_08
	//  `added ability to combine pdfs 
	// Modified by: Costas Manousakis-(Designer)-(1/25/18 15:41:10)
	Mods_2018_01
	//  `save selections and hilite sets (if they exist) from listboxes - 
	Mods_2018_07  //Fix page number error cause by fact that there were no image records loaded before while getting page count
	//Modified by: Chuck Miller (7/26/18 14:41:48)
	// Modified by: Costas Manousakis-(Designer)-(2/24/21 20:10:48)
	Mods_2021_WP
	//  `Call NTI_Print_CommentsWP_TIN to print comments
End if 
//
If (NTI_ImageSortNeeded_b)
	CONFIRM:C162("Images have been Re-arranged! Apply the new sequence before printing? If you do not, the arrangement will be lost!"; "Apply new Sequence")
	If (OK=1)
		NTI_ApplyImageSort
	Else 
		OBJECT SET VISIBLE:C603(*; "ImageSortWarning"; False:C215)
		NTI_ImageSortNeeded_b:=False:C215
	End if 
End if 
CUT NAMED SELECTION:C334([NTI_ELEM_TIN_INSP:185]; "$tempElem")
CUT NAMED SELECTION:C334([TIN_Insp_Comments:188]; "$TempCmts")
CUT NAMED SELECTION:C334([TIN_Insp_Images:186]; "$TempImages")
CUT NAMED SELECTION:C334([TIN_Insp_TmMembers:187]; "$tempTm")
C_BOOLEAN:C305($NBESETvalid_b; $ImgListSetValid_b)
4DError_b:=False:C215
ON ERR CALL:C155("4D_Errors")
$NBESETvalid_b:=True:C214
$ImgListSetValid_b:=True:C214
COPY SET:C600("$NBEElements0"; "$TempElemHilite")
If (4DError_b)
	$NBESETvalid_b:=False:C215
	4DError_b:=False:C215
End if 
COPY SET:C600("ImgListBoxSet"; "$TempImgHilite")
If (4DError_b)
	$ImgListSetValid_b:=False:C215
	4DError_b:=False:C215
End if 
ON ERR CALL:C155("")

INSP_PRN_InitVars

//count pages first
SHORT_MESSAGE("Counting Pages...")
C_LONGINT:C283(vTotalPages; vPageNo)
C_LONGINT:C283(viNumCmtsPgs; viCmtsPgStart; viSkPgStart; viChPgStart; viPhPgStart; vPrintPage1; viInspPreviewErr; vPrintPreview)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_LONGINT:C283(viNumSkPgs; viNumChPgs; viNumPhPgs; vPrintPontis; vPrintPontisField)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
vTotalPages:=0
SET PRINT PREVIEW:C364(False:C215)
C_BOOLEAN:C305(PrintFlag)
NTI_ListElements_TIN
C_LONGINT:C283($NTEPages_L)
C_REAL:C285($NTEPages_r; $CmtsPages_L; $Sketches_L; $Charts_L; $PhotosSingle_L; $Photos_L; $RecordCountToUse_L)

If (Records in selection:C76([NTI_ELEM_TIN_INSP:185])<=14)
	$NTEPages_L:=1
Else 
	$RecordCountToUse_L:=Records in selection:C76([NTI_ELEM_TIN_INSP:185])-14
	$NTEPages_r:=($RecordCountToUse_L/22)
	If ($RecordCountToUse_L%22=0)
		$NTEPages_L:=Trunc:C95($NTEPages_r; 0)+1
	Else 
		$NTEPages_L:=Trunc:C95($NTEPages_r; 0)+2
	End if 
End if 
viCmtsPgStart:=$NTEPages_L+1

NTI_ListInspImages

viNumCmtsPgs:=NTI_Print_CommentsWP_TIN(New object:C1471("printFlag"; False:C215))

NTI_CountInspImgPages

CLOSE WINDOW:C154

C_BOOLEAN:C305(bCmtsFlag; bPhotoFlag; bSketchFlag; bChartFlag)

vTotalPages:=$NTEPages_L+viNumCmtsPgs+viNumSkPgs+viNumChPgs+viNumPhPgs

//get which parts can be printed
bCmtsFlag:=(viNumCmtsPgs>0)
bPhotoFlag:=(viNumPhPgs>0)
bSketchFlag:=(viNumSkPgs>0)
bChartFlag:=(viNumChPgs>0)

C_LONGINT:C283($pages_L)

viInspPreviewErr:=0  //initialize error to zero
vPrintPreview:=0

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674("PrintTINInspRpt"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")

//$FormWindow:=Open form window([Dialogs];"PrintInspRpt2")
DIALOG:C40("PrintTINInspRpt")
CLOSE WINDOW:C154($Win_l)

If (OK=1)
	PrintFlag:=False:C215
	vPrintPontisField:=0
	G_PrintOptions
	If (<>ShowPrint)
		PRINT SETTINGS:C106
	End if 
	
	If (OK=1)
		
		PrintFlag:=True:C214
		If (vPrintPreview=1)
			SET PRINT PREVIEW:C364(True:C214)
			ON ERR CALL:C155("G_PrintError")  //Set error handler for quiting from Preview
		End if 
		
		G_PrintOptions
		
		Print_initPrintToPDF
		
		If (vPrintPage1=1)
			vPrintPontis:=1
			NTI_Print_TIN
		End if 
		
		vPageNo:=viCmtsPgStart-1
		If ((vPrintCmts=1) & (Ok=1))
			$pages_L:=NTI_Print_CommentsWP_TIN(New object:C1471("printFlag"; True:C214))
		End if 
		vPageNo:=viCmtsPgStart+viNumCmtsPgs-1
		
		If (((vPrintPhotos=1) | (vPrintSketches=1) | (vPrintCharts=1)))
			NTI_PrintImages
		Else 
			
		End if 
		If ((vPrintPhotos=1) | (vPrintSketches=1) | (vPrintCharts=1) | (vPrintPage1=1) | (vPrintCmts=1))
			PAGE BREAK:C6  //spool it
		End if 
		If (vPrintPreview=1)
			SET PRINT PREVIEW:C364(False:C215)
			ON ERR CALL:C155("")  //clear error handler for quiting from Preview
		End if 
		
		If (PRINT_PdfDest_b)
			PRINT_CombinePdfs
		End if 
		
		If (PrintNTIE_L=1)
			Print form:C5([NTI_TunnelInfo:181]; "NTIED_Print")
		End if 
		CLOSE PRINTING JOB:C996
		SET PRINT OPTION:C733(Spooler document name option:K47:10; "")
		SET PRINT OPTION:C733(Destination option:K47:7; 1)
		
	End if 
	
End if 

USE NAMED SELECTION:C332("$tempElem")
USE NAMED SELECTION:C332("$TempCmts")
USE NAMED SELECTION:C332("$TempImages")
USE NAMED SELECTION:C332("$tempTm")
If ($NBESETvalid_b)
	COPY SET:C600("$TempElemHilite"; "$NBEElements0")
	CLEAR SET:C117("$TempElemHilite")
End if 
If ($ImgListSetValid_b)
	COPY SET:C600("$TempImgHilite"; "ImgListBoxSet")
	CLEAR SET:C117("$TempImgHilite")
End if 
//End NTI_PrintInspection