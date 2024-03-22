//%attributes = {"invisible":true}
//Method: NTI_Print_CommentsWP_BIN
//Description
// print NTI comments for a BIN inspection using Write Pro
// Parameters
// $0 : $NumPages_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/12/21, 12:41:50
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_LONGINT:C283(NTI_Print_CommentsWP_BIN; $0)
	
End if 
//

C_LONGINT:C283($0)  //num pages

C_BOOLEAN:C305($bGeneral; $bOtherCmts)
C_LONGINT:C283($vAllElmts; $numpages; $viNElmts; $i)
C_BOOLEAN:C305(PrintFlag; $bViewAllCmtsFlag)
C_LONGINT:C283(viInspPreviewErr)  // **replaced _ o _C_INTEGER()
C_LONGINT:C283(INSP_PrevElmtParntID)
INSP_PrevElmtParntID:=0

$0:=0  //initialize to zero

C_BOOLEAN:C305($PrintCmts_b; $ShowAllComments_b)
$PrintCmts_b:=True:C214
$ShowAllComments_b:=False:C215

C_TEXT:C284($vElmTitle)

//create main write pro area
C_OBJECT:C1216($WPArea_)
$WPArea_:=INSP_InitializeWPArea(New object:C1471("templateType"; "Normal"))

$viNElmts:=Records in selection:C76([NTI_ELEM_BIN_INSP:183])
If ($viNElmts>0)
	
	FIRST RECORD:C50([NTI_ELEM_BIN_INSP:183])
	For ($i; 1; $viNElmts)
		//RELATE ONE([ElementsSafety]ElementNo)
		
		If (BLOB size:C605([NTI_ELEM_BIN_INSP:183]ELEM_NOTES:9)>0)
			QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
			If ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
				$vElmTitle:=[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5
				QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7)
				$vElmTitle:=[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5+" ("+String:C10([NTI_ELEM_DEFS:182]ELEM_KEY:4)+") - "+$vElmTitle
			Else 
				$vElmTitle:=[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5+" ("+String:C10([NTI_ELEM_DEFS:182]ELEM_KEY:4)+")"
			End if 
			G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [NTI_ELEM_BIN_INSP:183]ELEM_NOTES:9)
		End if 
		NEXT RECORD:C51([NTI_ELEM_BIN_INSP:183])
	End for 
End if 

$numpages:=WP Get page count:C1412($WPArea_)

C_OBJECT:C1216($pipParamObj)
$pipParamObj:=wrpPrintInPartsNewParamObj
$pipParamObj.isOpenPrintingJob:=False:C215  // True=OpenPrintingJobIsGiven , False=NoOpenPrintingJobIsGiven

// typical pages
$pipParamObj.PagesFormName:="NTECmtsPrintWP"
$pipParamObj.PagesFormTable:=Table:C252(->[Inspections:27])
$pipParamObj.firstPageFormName:="NTECmtsPrintWP"
$pipParamObj.firstPageFormTable:=Table:C252(->[Inspections:27])

wrpCustomPrintParts($WPArea_; $pipParamObj)

$0:=$numpages

//End NTI_Print_CommentsWP_BIN