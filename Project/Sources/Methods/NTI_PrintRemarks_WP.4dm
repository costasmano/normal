//%attributes = {"invisible":true}
//Method: NTI_PrintRemarks_WP
//Description
//
// Parameters
// $1 : $WPDoc_obj
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/08/21, 18:58:58
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(NTI_PrintRemarks_WP; $1)
	
End if 
//

C_OBJECT:C1216($1; $wpArea)

$wpArea:=$1

C_OBJECT:C1216($pipParamObj)
$pipParamObj:=wrpPrintInPartsNewParamObj
$pipParamObj.isOpenPrintingJob:=False:C215  // True=OpenPrintingJobIsGiven , False=NoOpenPrintingJobIsGiven

// typical pages
$pipParamObj.PagesFormName:="WPCmtsPrint"
$pipParamObj.PagesFormTable:=Table:C252(->[TIN_Inspections:184])
$pipParamObj.firstPageFormName:="WPCmtsPrint"
$pipParamObj.firstPageFormTable:=Table:C252(->[TIN_Inspections:184])

wrpCustomPrintParts($wpArea; $pipParamObj)

//End NTI_PrintRemarks_WP