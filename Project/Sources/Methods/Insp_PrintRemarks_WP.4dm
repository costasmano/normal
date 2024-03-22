//%attributes = {"invisible":true}
//Method: Insp_PrintRemarks_WP
//Description
//
// Parameters
// $1 :$WpArea_obj
// $2 : $FirstPageForm_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/24/21, 21:40:03
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(Insp_PrintRemarks_WP; $1)
	C_TEXT:C284(Insp_PrintRemarks_WP; $2)
End if 
//

C_OBJECT:C1216($1; $wpArea)
C_TEXT:C284($firstPageForm)

$wpArea:=$1
$firstPageForm:=""
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$firstPageForm:=$2
End if 

C_OBJECT:C1216($pipParamObj)
$pipParamObj:=wrpPrintInPartsNewParamObj
$pipParamObj.isOpenPrintingJob:=False:C215  // True=OpenPrintingJobIsGiven , False=NoOpenPrintingJobIsGiven

If ($firstPageForm#"")
	// if the first page is different than the rest
	$pipParamObj.firstPageFormName:=$firstPageForm
	$pipParamObj.firstPageFormTable:=Table:C252(->[Inspections:27])
Else 
	$pipParamObj.firstPageFormName:="WPCmtsPrint"
	$pipParamObj.firstPageFormTable:=Table:C252(->[Inspections:27])
End if 
// typical pages
$pipParamObj.PagesFormName:="WPCmtsPrint"
$pipParamObj.PagesFormTable:=Table:C252(->[Inspections:27])
wrpCustomPrintParts($wpArea; $pipParamObj)

//End Insp_PrintRemarks_WP